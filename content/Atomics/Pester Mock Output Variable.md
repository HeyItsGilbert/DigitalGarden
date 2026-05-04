---
date: 2025-09-01
share: true
tags:
  - PowerShell
aliases: []
---
This was a suggested apprach by the genius Chris Dent.  
```powershell  
$c = New-PesterContainer -ScriptBlock {  
    Describe 'test' {  
        BeforeAll {  
            function Invoke-TestSubject {  
                $foo = $null  
                Invoke-RestMethod https://www.google.com -StatusCodeVariable foo  
                $foo -eq 204  
            }  
        }  
        It 'Should deal with StatusCodeVariable' {  
            Mock Invoke-RestMethod {  
                $caller = Get-PSCallStack | Where-Object FunctionName -eq 'Invoke-TestSubject'  
                $variables = $caller.GetFrameVariables()  
                $variables[$StatusCodeVariable].Value = 204  
            }  
            $foo = $null  
            Invoke-TestSubject | Should -BeTrue  
        }  
    }  
}  
Invoke-Pester -Container $c -Output Detailed  
```