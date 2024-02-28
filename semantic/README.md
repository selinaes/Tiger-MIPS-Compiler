# Sematic Analysis

## Type Lattice

```
           unit
      /    /    \    \
    int string array record
    \     |     \    /
     \    |       nil
      \   |        |
      impossibility (will not return value)
```

Above is the subtyping system we use to process semantic analysis. 

## Rule

- when checking `if then`, we allowed side effect statement. That means `then` can return anything including `unit`. This is equalivent to 

```
fun f() = 
    if true
    then 1; ()
```

- when checking `if then else`, we allowed the `then` and `else` branches to have different type, and regard them as both subtypes of `unit`, so the whole statement returns a type `unit`. Example: 

```
if (5>4) then 13 else  " "
if (x < y) then f() else g()
```

- type declaration: name cannot redefined within the same group. But it can redefine in the different group. And the latter will shadow the former declaration.

- function declaration: similar to type declaration, function name cannot redefined within the same group, but in different group. No overload supported. 

- procedure definition: the return type is unit, which means it convers all subtype. For example, the following `test40.tig` is regarded as valid, returns a unit. No type inference supported.

```
function g(a:int) = a
```

- for/while expression: the grammar for `for` is `FOR ID ASSIGN exp TO exp DO exp`, and the `exp` after `DO` must be a statement with no value. However, we allow subtyping, and if the `exp` has a value, we regard it as only being used for side-effect, therefore legal. Similarly for while. For example: 
```
while(10 > 5) do 5+6
```
