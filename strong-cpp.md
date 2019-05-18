# Introduction

The central theme of this book is that 

 * segfaults caused by attempts to dereference null pointers, or access to uninitialized memory
 C++11 provided mechanisms to reduce this class of error
 
  * Impossible states
  requires discipline(?) to fix ... requires sounds software design principles, built around strong types
  st.
  impossible states are not representable

## Operational vs. denotational reasoning

Avoidance of copies, memory re-allocation etc.

## C++ jargon

The C++ language has developed in isolation to mainstream programming languages, acquiring a cult of ad-hoc names unused outside of C++.
These will be marked in this text as :alien: and translated into conventional language.

## Deprecated C++ features

Old-school C++ features are included for completeness, because you are quite likely to come across these in real-world codebases. Marked with :skull:

# Statements vs. Expressions

http://www.haskellforall.com/2013/07/statements-vs-expressions.html

# Types

## Basic types

bool, int, float, double, std::string

## Initialization

```
int x=3;
int y{7};
```

## Type inference

auto s = "Hi there";

## Type construction

Unit: `std::monostate`

Sum types: `std::variant<Ts...>`

Product types: `struct`

## Basic containers

### Maybe: `std::optional<T>`

### Either, Result: `std::expected<...>`
https://github.com/TartanLlama/expected

### Tuple: `std::tuple`, `std::pair`

structured binding:alien:

### Vector, Map

## Type aliases

`using`
was `typedef`:skull:

# Function closures

https://en.wikipedia.org/wiki/Closure_(computer_programming)

## Lambda syntax

Capture by reference, capture by copy

## Structs with operator `()`

Sometimes confusingly called `Functors`

## Named functions

assignment to `std::function`, with capture of `this`

```
#include <functional>
#include <string>

struct CounterXY {
    int x{0};
    int y{0};
    
    std::function<void()> incrementX = [this]() {
        x++;
    };

    std::function<void()> incrementY = [this]() {
        y++;
    };

    std::function<std::string()> to_string = [this]() {
        return parens<int, int>(x, y);
    };
};
```

## member function syntax

## Structs with visibility

 `private`

`class` keyword

# Operational type hints

## Ownership

not reified, maintained through type hints

## Construction, copy, move, destruct

lvalue references

rvalue references

non-copyable objects

`std::unique_ptr<T>`

## Immutability annotation: const (cv-qualification:alien:)

### const variable

### const argument

### value returned by function is const
usually const-ref: I'm giving you a reference for efficiency's sake, but you're not allowed to modify it)

### closure does not modify environment

class method with `const` suffix keyword

lambda: 

```
[&best_string = std::as_const(best_string)](const string& s)
{
    best_string = s; // fails
};
```

### `const_cast<T>`

## Universal references

auto&&
const auto&&

# Function application

## Ranges
https://github.com/ericniebler/range-v3

## One-shot application (not composable)

```c++
for(auto&& [k, v] : map) {
   // Do stuff with k and v
}
```

## Iterators and iterator algorithms :skull:

# Polymorphism

## template parameters

## SFINAE:alien: and duck typing

## Forcing SFINAE:alien: to fail: type traits

`enable_if<>`
`is_same_v<X, Y>`

## template parameter lists, recursive templates

:alien: "variadic templates"

```c++
template <typename T>
std::string parens_tail(T x) {
    return std::to_string(x) + ")";
}

template <typename T, typename... Args>
std::string parens_tail(T x, Args... args) {
    return std::to_string(x) + ", " + parens_tail<Args...>(args...);
}

template <typename... Args>
std::string parens(Args... args) {
    return "(" + parens_tail(args...);
}
```

## Subtype polymorphism (inheritance)

colon syntax: declaration of inherit-from

`using`

`protected` visibility specifier

## Static subtype polymorphism (CRTP:alien:)

Defining a static interface

## Dynamic subtype polymorphism (virtual methods :alien:)

Defining a dynamic interface

# Working with `std::optional`

## Visitors

## Generic visitors
`decltype`
`decay_t`
SFINAE guards

## std::monostate

Use as the first argument to ensure the variant is default-constructible:alien:.

# Practical software construction

## Make small types

Don't have non-interacting basic types within the same class

## Add tiny unit checks for sanity

Ensure that the object can be constructed/destructed without error
Ensure that some basic sequences of operation occur as expected

## Add property tests

https://github.com/emil-e/rapidcheck

How to define an instance of `Arbitrary<T>` for each of your small classes

How to define `Arbitrary<T>` for your bigger composed classes

How to make useful checks, eg:
  * roundtrip encode/decode

## Add regression tests with real-world data

As bugs are discuvered, save a (minimal) input that triggered the bug. If you
are well-disciplined, do this first before attempting to fix the issue, in
which case running the test case becomes your build target while developing the
fix.