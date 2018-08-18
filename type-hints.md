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
