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
