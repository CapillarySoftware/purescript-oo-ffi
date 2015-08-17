## Module Data.Foreign.OOFFI

#### `getter`

``` purescript
getter :: forall o a eff. String -> o -> Eff eff a
```

#### `modifier`

``` purescript
modifier :: forall o a b eff. String -> o -> (a -> b) -> Eff eff b
```

#### `setter`

``` purescript
setter :: forall o a eff. String -> o -> a -> Eff eff a
```

#### `getterC`

``` purescript
getterC :: forall a eff. String -> Eff eff a
```

#### `modifierC`

``` purescript
modifierC :: forall a b eff. String -> (a -> b) -> Eff eff b
```

#### `setterC`

``` purescript
setterC :: forall a eff. String -> a -> Eff eff a
```

#### `method0`

``` purescript
method0 :: forall o a. String -> o -> a
```

#### `method0C`

``` purescript
method0C :: forall a eff. String -> Eff eff a
```

#### `method0Eff`

``` purescript
method0Eff :: forall o a eff. String -> o -> Eff eff a
```

#### `method0EffC`

``` purescript
method0EffC :: forall a eff. String -> Eff eff a
```

#### `method1`

``` purescript
method1 :: forall o a b. String -> o -> a -> b
```

#### `method1C`

``` purescript
method1C :: forall a b eff. String -> a -> Eff eff b
```

#### `method1Eff`

``` purescript
method1Eff :: forall o a b eff. String -> o -> a -> Eff eff b
```

#### `method1EffC`

``` purescript
method1EffC :: forall a b eff. String -> a -> Eff eff b
```

#### `method2`

``` purescript
method2 :: forall o a b c. String -> o -> a -> b -> c
```

#### `method2C`

``` purescript
method2C :: forall a b c eff. String -> a -> b -> Eff eff c
```

#### `method2Eff`

``` purescript
method2Eff :: forall o a b c eff. String -> o -> a -> b -> Eff eff c
```

#### `method2EffC`

``` purescript
method2EffC :: forall a b c eff. String -> a -> b -> Eff eff c
```

#### `method3`

``` purescript
method3 :: forall o a b c d. String -> o -> a -> b -> c -> d
```

#### `method3C`

``` purescript
method3C :: forall a b c d eff. String -> a -> b -> c -> Eff eff d
```

#### `method3Eff`

``` purescript
method3Eff :: forall o a b c d eff. String -> o -> a -> b -> c -> Eff eff d
```

#### `method3EffC`

``` purescript
method3EffC :: forall a b c d eff. String -> a -> b -> c -> Eff eff d
```

#### `method4`

``` purescript
method4 :: forall o a b c d e. String -> o -> a -> b -> c -> d -> e
```

#### `method4C`

``` purescript
method4C :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
```

#### `method4Eff`

``` purescript
method4Eff :: forall o a b c d e eff. String -> o -> a -> b -> c -> d -> Eff eff e
```

#### `method4EffC`

``` purescript
method4EffC :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
```

#### `method5`

``` purescript
method5 :: forall o a b c d e f. String -> o -> a -> b -> c -> d -> e -> f
```

#### `method5C`

``` purescript
method5C :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
```

#### `method5Eff`

``` purescript
method5Eff :: forall o a b c d e f eff. String -> o -> a -> b -> c -> d -> e -> Eff eff f
```

#### `method5EffC`

``` purescript
method5EffC :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
```

#### `instantiate0From`

``` purescript
instantiate0From :: forall o a eff. String -> o -> Eff eff a
```

#### `instantiate0`

``` purescript
instantiate0 :: forall a eff. String -> Eff eff a
```

#### `instantiate1From`

``` purescript
instantiate1From :: forall o a b eff. String -> o -> a -> Eff eff b
```

#### `instantiate1`

``` purescript
instantiate1 :: forall a b eff. String -> a -> Eff eff b
```

#### `instantiate2From`

``` purescript
instantiate2From :: forall o a b c eff. String -> o -> a -> b -> Eff eff c
```

#### `instantiate2`

``` purescript
instantiate2 :: forall a b c eff. String -> a -> b -> Eff eff c
```

#### `instantiate3From`

``` purescript
instantiate3From :: forall o a b c d eff. String -> o -> a -> b -> c -> Eff eff d
```

#### `instantiate3`

``` purescript
instantiate3 :: forall a b c d eff. String -> a -> b -> c -> Eff eff d
```

#### `instantiate4From`

``` purescript
instantiate4From :: forall o a b c d e eff. String -> o -> a -> b -> c -> d -> Eff eff e
```

#### `instantiate4`

``` purescript
instantiate4 :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
```

#### `instantiate5From`

``` purescript
instantiate5From :: forall o a b c d e f eff. String -> o -> a -> b -> c -> d -> e -> Eff eff f
```

#### `instantiate5`

``` purescript
instantiate5 :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
```


