% Functional Programming in C++
% Conrad Parker
% Hong Kong Functional Programming Meetup, May 28, 2019

# What is C++

C++ is a slowly-maturing language:

  * performance-centric, zero-overhead abstractions
  * strict constraints on backwards-compatibility

Originally "Object Oriented" (subtype polymorphism), now "Multi-paradigm".

# Useful types for functional programming

Recent and future revisions introduce some familiar types and features:

  * `std::optional` (C++17)
  * `std::expected` (C++20)
  * `std::variant` (C++17)
  * `std::monostate` (C++17)
  * `lambdas` (C++11)
  * `std::function` (C++11)
  * `ranges` (C++20)

# std::optional (C++17)

```haskell
  data M = Maybe Int
```

In C++:

```cpp
  using M = std::optional<int>;
```

# std::expected (C++20)

```haskell
  data E = Either Int String
```

In C++:

```cpp
#include <expected>

using E = std::expected<int, std::string>;
```

`std::expected` vs. exceptions ?

  * use exceptions in constructors for RAII

# `std::variant` (C++17)

```haskell
    data Food = Bread | Eggs Int
```

In C++:

  * `enum`?

```cpp
#include <variant>

struct Bread {};
struct Eggs { int nr_eggs; };
using Food = std::variant<Bread, Eggs>;
```

# A bit more verbose ...
```haskell
data Food = Bread | Eggs Int
    deriving (Show, Eq)
```


```cpp
struct Eggs {
    int nr_eggs;

    bool operator==(const Egg& other) const {
        return nr_eggs == other.nr_eggs;
    }   
    
    friend std::ostream& operator<<(std::ostream& os, const Eggs& eggs) {
        return os << "Egg{" << eggs.nr_eggs << "}";
    };  
};  
```

# `std::monostate` (C++17)

```haskell
  ()
```

C++:

```cpp
  namespace std {
      struct monostate {};
  }
```

Which you can use as:
```cpp
#include <variant>
  std::monostate{};
```
or (usually) via brace-initialization as:
```cpp
  {};
```

# Why `#include <variant>`?

`std::monostate` is defined in `<variant>` because it was
required to allow variant types to be default constructible.

```cpp
  using SuperFood =
    std::variant<std::monostate, Bread, Eggs>;
  ...
  auto super = SuperFood();
```

# Pattern matching on variants (C++20)

Define `match()`:

```cpp
template <class... Ts>
struct match : Ts...
{
    using Ts::operator()...;
};        
template <class... Ts>
match(Ts...)->match<Ts...>;
```

# Pattern matching on variants

```haskell
calories :: Food -> Int
calories Bread = 265;
calories (Eggs n) = n * 78;
```

In C=+, using `match()`:

```cpp
int calories(const Food& food) {
    return std::visit(match{
        [](const Bread& bread) {
            return 265;
        },
        [](const Eggs& eggs) {
            return eggs.nr_eggs * 78;
        }
    }, food);
}
```

# Lambdas (C++11)

```haskell
    doubleIt = \x -> x * 2
```

```cpp
    auto double_it = [](int x) -> int {
        return x * 2;
    };
```

# `std::function` (C++11)

```cpp
#include <functional>

int apply_int_func(std::function<int(int)> f, int x)
{
    return f(x);
}
```

# Ranges (C++20)

```cpp
#include <ranges>

std::vector<int> ints{0,1,2,3,4,5};
auto even = [](int i){ return 0 == i % 2; };
auto square = [](int i) { return i * i; };

auto squared_evens =
    ints
    | std::view::filter(even)
    | std::view::transform(square);
```

# Putting it all together

  * Smaller classes: use `std::variant` etc. to clean up big classes
  * Make impossible states unrepresentable
  * No "valid" flags in classes

  * Design for totality: no leaks in data structures,
    no impossible states
  * Making impossible states unrepresentable

StrongC++

  * Correctness by Construction
  * Declarative by Design

# Discussion

Conrad Parker <conrad@metadecks.org>

  * HK C++ Meetup: Thursday July 18
