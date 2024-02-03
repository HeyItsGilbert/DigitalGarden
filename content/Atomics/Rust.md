---
date: 2022-12-03
tags:
  - coding
aliases: 
modified: 2024-02-02T21:37:45-08:00
share: true
---

## Variables
- Variables are set with `let`.
- A variable is not mutable by default. To make a var mutable you need to append `mut` after `let`.

## Conditionals
- Rust always require if statements to have elses.

## Functions
Functions that return data must have a return type:
```
fn foobar() -> string {
  let foo = "foo";
  foo
}
```
If you don't end the line (`;`) the value will be passed back out.

## Datatypes
You can mark the data type of variable you append it with a : and type (e.g `:i32` ).
See: https://doc.rust-lang.org/book/ch03-02-data-types.html

## Structures
Similar to shapes in Hack. You use `impl` for implementations of structures.
```
struct Emp {
  name: str,
  age: i32,
}

impl Emp {
  fn first_name(&self) -> str {
    //Code to grab first name
    self.name //etc.
  }
}
```

Functions inside of structure are referred to as methods.  It should always be passed in `&self`.

## Misc
`<type/module>::function` The `::` are known as the scope resolution operator. 

You can use the `use` operator at the top of a file and then you don't need to use the fulle name with the scope resolution operator.

## Cargo
The way to create or run packages. `cargo new`  or `cargo run`.

## Memory Management
Stacks are use to store information when the size is known, and heaps are used for when the sizes are unknown.
- https://subscription.packtpub.com/video/programming/9781801818179/p5/video5_3/scope-pointers-and-heap
Variables are scoped only to it's function.
Rules of Ownership:
1. Each value in Rust has a variable that's called its owner.
2. There can only be one owner at a time.
3. When the owner goes out of scope, the value will be dropped.

![[Pasted image 20221204082956.png|Pasted image 20221204082956.png]]
Stack (s1) has a pointer to the first value in the heap. Uses the length to understand how long to keep going. Capacity?

If you use another variable to the same pointer, the first variable can no longer be it's owner (see rules of ownership). You can use `.clone()` to make a copy. The first is known as shallow copy and the latter is a deep copy.

You can also pass a reference to avoid making a copy. References are prepended with `&` (e.g. `&foo`). You can make references mutable.

Things that live in heap are unknown to the program during compile. Therefore it's possible that the program compiles but throw's an error.

## Arrays
Similar to most languages. You can use a `;` syntax to create a generator. Cannot be a mixed of data.
```
let numList = [1,2,3,4]
let foo = ["hi";3] // hi, hi, hi
```
Rust uses 0 index.

You can use a reference in a for loop: `for i in &a`.

You can also the `.iter()` to turn it into an enumerator object. It comes with some nice functions for free (e.g. `.reverse()`, `.count()`)

## Tuples
```
let t = (1,2,3,"Four")

// Define acceptable data types
let t: (i32, &str) = (1, "Four")
```
Can be mixed values.

You can access an item in the tuple by appendin the position to the variable. Example above `t.2` would be `3`.

## Vectors
Similar to arrays. Vectors use heaps and arrays use stack.

## Hashmaps
```
let mut foo = HashMap::new();
foo.insert(String::from("foo"),20)
foo.insert(String::from("bar"),10)
```
You can `.get(key)` from hashmaps. It returns an Option (see No Null).
```
for (key,value) in &foo {}
```

## Type Casting
`var as i32`

## Errors
There are 2: Recoverable and unrecoverable.
```
panic!("Oh damn");
```
Recoverable errors throw an Enum called `Result<T,E>` which are typically implemented by the modules.
```
let f = File::open("anfile.txt");
// We reinspect it and see if it did what we expect
let f = match f {
  OK(file) => file,
  Err(error) => panic!("File doesn'te exist fool: {:?}", error);
}
```

Another way you can deal with this is use `.expect("An Error")` with your  calls.

## No Null
There are no nulls. You get an enum `Option<T>` with `Some(T), None(T)`. You can start with None.
See: https://dev.to/joelnet/null-the-billion-dollar-mistake-maybe-just-nothing-1cak

## From and Into
This is an implementation for structures that are changing types.

See: https://doc.rust-lang.org/rust-by-example/conversion/from_into.html

## Strings
`str` is the unmutable version. `&str` is the mutable version and you'll that that with interpolated or double quotes string (e.g. `let a = "foo"` vs `let a = 'foo'`).
> In Rust, str is a primitive type that represents a sequence of Unicode scalar values, also known as a string slice. This means that it is a read-only view into a string, and it does not own the memory that it points to. On the other hand, String is a growable, mutable, owned string type.
https://stackoverflow.com/a/74674243/1585481

## Flow of Control
Similar to most languages [[Control Flow|Control Flow]].

Instead of case there's `match`. There is also `if let` and `while let`.
```

```
