---
modified: 2026-02-26T18:08:28-08:00
date: 2024-02-11
share: true
tags:
aliases:
  - golang
created: 2024-02-11
---
Googles compilable [[Programming MOC|programming language]]. It has easy support to generate cross platform binaries that are often very small.  
## [[Concurrency|Concurrency]]  
One of Go's selling points is it's ability to handle async requests easily.  
## Structs not Classes  
Golang doesn't have classes or abstracts like .net.  Structs are similar but have their own nuance.  
## Go-isms  
- error handling: It's a very common  
See https://github.com/pthethanh/effective-go  
## [[Control Flow|Control Flow]]  
### `if-else`  
```go  
if InitSimpleStatement; Condition {  
	// do something  
} else {  
	// do something  
}  
```  
## [[Formatting|Formatting]] & [[Linting|Linting]]  
- `gofmt` is a standard to format your go code.