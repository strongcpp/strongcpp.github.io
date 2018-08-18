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
