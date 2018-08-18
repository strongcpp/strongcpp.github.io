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
