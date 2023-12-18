#require powershell-yaml
<#
.SYNOPSIS
  A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
  A longer description of the function, its purpose, common use cases, etc.
.NOTES
  Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
  Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
  Test-MyTestFunction -Verbose
  Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
[CmdletBinding(SupportsShouldProcess = $True)]
param (
  [ValidateScript({
      if ( -Not ($_ | Test-Path) ) {
        throw 'File or folder does not exist'
      }
      return $true
    })]
  [System.IO.FileInfo]
  $Source,
  [ValidateScript({
      if ( -Not ($_ | Test-Path) ) {
        throw 'File or folder does not exist'
      }
      return $true
    })]
  [System.IO.FileInfo]
  $DestinationPath
)

# Function to get notes
function ParseNote {
  param (
    [System.IO.FileInfo]
    $File
  )

  Write-Debug "Parsing $($File.BaseName)"

  # Read the file
  $raw = Get-Content $File

  # Pull out the metadata from frontmatter
  # Front matter always starts on the first line and there should be at least 2
  if ($raw[0] -match '---' -and ($raw -match '---').Count -ge 2) {
    Write-Debug 'Frontmatter detected'
    for ($i = 1; $i -lt $raw.Count; $i++) {
      if ($raw[$i] -match '---') {
        $raw_yaml = $raw[1..($i - 1)]
        $post = $raw[($i + 1)..($raw.Count)]
        break
      }
    }
    $fm = $raw_yaml | ConvertFrom-Yaml
  } else {
    # No frontmatter, set these to work on below
    $fm = @{}
    $post = $raw
    Write-Warning ("{0} is missing frontmatter! It won't be published." -f $File.BaseName)
  }

  # Check for title and add/remove as necessary
  if ($post[0] -match '^#') {
    Write-Host 'Header detected, removing'
    # if no title set, add it
    if (-Not ($fm.Contains('title'))) {
      $fm['title'] = $post[0] -replace '^#'
    }
    # Remove the header line
    $post = $post[1..($post.Count)]
  }

  # Rebuild the content
  $content = @()
  $content += '---'
  $content += $fm | ConvertTo-Yaml
  $content += '---'
  $content += $post
  
  return [PSCustomObject]@{
    Name = $File.BaseName
    Frontmatter = $fm
    Content = $content
  }
}

function ConvertLinks {
  param (
    $content
  )
  # Iterate over each line
  return $content | ForEach-Object {
    # Find links and replace them
    if ($_ -match '\[\[.*\]\]') {
      # ToDo Replace with Hugo syntax
      $_ -replace '\[\[([^\[\]]+)\]\]', '[$1]({{< ref "$1" >}})'
    } else {
      $_
    }
  }
}

function PendingDoc {
  param (
    [String]
    $Title
  )
  $content = @()
  $content = @()
  $content += '---'
  $content += $fm | ConvertTo-Yaml
  $content += '---'
  $content += $post
  return $content
}

# Get current directory
Set-Location $PSScriptRoot

# Clean up destination directory
Get-ChildItem -Recurse $DestinationPath | ForEach-Object {
  if ($PSCmdlet.ShouldProcess($_, 'Delete')) {
    Remove-Item -Recurse -Force $_
  }
}

# Get all the notes
$notes = Get-ChildItem -Recurse $Source -File -Filter '*.md'
Write-Debug "Notes detected: $($notes.BaseName -join ',' )"

$notes | ForEach-Object {
  # Parse Each Note
  $note = ParseNote $_

  # Skip if missing frontmatter
  if (-Not($note.Frontmatter)) { continue }
  # Skip is missing posted frontmatter value or is false
  if (-Not ($note.Frontmatter.published)) { continue }

  # Using the relative path will allow us to keep the 
  $relative = (Resolve-Path $_ -Relative) -replace '^./', ''
  # Construct the final location for the file in the destination
  $destination = Join-Path (Resolve-Path $DestinationPath) $relative
  Write-Debug "Destination: $destination"

  # Create the destination folder recursively if it is missing
  $destFolder = Split-Path $destination
  if (-Not(Test-Path $destFolder)) {
    if ($PSCmdlet.ShouldProcess($destFolder, 'Creating folder')) {
      New-Item -ItemType Directory -Path $destFolder
    }
  }

  # Dump the processed note to the destination
  if ($PSCmdlet.ShouldProcess($destination, 'Set the content')) {
    Set-Content -Value (ConvertLinks $note.Content) -LiteralPath $destination
  }
}