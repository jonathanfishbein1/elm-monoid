module Monoid exposing
    ( Monoid
    , Sum(..)
    , Product(..)
    , monoid
    , empty
    , append
    , concat
    , string
    , sum
    , product
    , list
    , array
    , dict
    , set
    , cmd
    , sub
    )

{-| A module to define generic functions for monoid.
For instance, we defined generic `concat` in this module using `Monoid` type as follows.

    concat : Monoid a -> List a -> a
    concat m =
        List.foldr (append m) (empty m)

    concat string ["foo", "bar", "baz"]
    --> "foobarbaz"

    concat list [[1, 2, 3], [4, 5], [6]]
    --> [1, 2, 3, 4, 5, 6]

    concat sum [Sum 1, Sum 2, Sum 3, Sum 4] -- 1 + 2 + 3 + 4
    --> Sum 10

    concat sum <| List.map Sum [1, 2, 3, 4] -- 1 + 2 + 3 + 4
    --> Sum 10

    concat product <| List.map Product [1, 2, 3, 4] -- 1 * 2 * 3 * 4
    --> Product 24


# Types

@docs Monoid
@docs Sum
@docs Product


# Constructors

@docs monoid


# Functions for unwraping Monoid

@docs empty
@docs append


# Convenient functions for monoid

@docs concat


# Monoid types for popular types

@docs string
@docs sum
@docs product
@docs list
@docs array
@docs dict
@docs set
@docs cmd
@docs sub

-}

import Array
import Dict
import SemiGroup
import Set



-- Types


{-| Main type.
-}
type Monoid a
    = Monoid
        { mempty : a
        , mappend : SemiGroup.SemiGroup a
        }



-- Constructors


{-| Constructor for `Monoid`.
-}
monoid : a -> (a -> a -> a) -> Monoid a
monoid mempty mappend =
    Monoid
        { mempty = mempty
        , mappend = SemiGroup.SemiGroup mappend
        }



-- Functions for unwraping monoid


{-| Take the identity element of a monoid.
-}
empty : Monoid a -> a
empty (Monoid { mempty }) =
    mempty


{-| Take the way to append a monoids.
-}
append : Monoid a -> (a -> a -> a)
append (Monoid { mappend }) =
    let
        (SemiGroup.SemiGroup semigroupAppend) =
            mappend
    in
    semigroupAppend



-- Convenient functions for monoids


{-| Concatenate list of monoid.
-}
concat : Monoid a -> List a -> a
concat m =
    List.foldr (append m) (empty m)



-- Monoid types for popular types


{-| `Monoid` type for `String`.
-}
string : Monoid String
string =
    monoid "" (++)


{-| `Monoid` under addition
-}
type Sum a
    = Sum a


{-| `Monoid` type for `Sum`.
-}
sum : Monoid (Sum number)
sum =
    monoid (Sum 0) (\(Sum a) (Sum b) -> Sum <| a + b)


{-| `Monoid` under multiplication.
-}
type Product a
    = Product a


{-| `Monoid` type for `Product`.
-}
product : Monoid (Product number)
product =
    monoid (Product 1) (\(Product a) (Product b) -> Product <| a * b)


{-| `Monoid` type for `List`.
-}
list : Monoid (List a)
list =
    monoid [] (++)


{-| `Monoid` type for `Array`.
-}
array : Monoid (Array.Array a)
array =
    monoid Array.empty Array.append


{-| `Monoid` type for `Dict`.
-}
dict : Monoid (Dict.Dict comparable a)
dict =
    monoid Dict.empty Dict.union


{-| `Monoid` type for `Set`.
-}
set : Monoid (Set.Set comparable)
set =
    monoid Set.empty Set.union


{-| `Monoid` type for `Cmd`.
-}
cmd : Monoid (Cmd comparable)
cmd =
    monoid Cmd.none (\a b -> Cmd.batch [ a, b ])


{-| `Monoid` type for `Sub`.
-}
sub : Monoid (Sub comparable)
sub =
    monoid Sub.none (\a b -> Sub.batch [ a, b ])
