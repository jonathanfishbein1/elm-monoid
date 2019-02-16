module TestMonoid exposing (suite)

import Expect
import Fuzz
import Monoid
import Test


suite : Test.Test
suite =
    Test.describe "The Monoid module"
        [ Test.fuzz Fuzz.string "tests that ++ equivalent to Monoid.append for list" <|
            \randomlyGeneratedString ->
                let
                    expected =
                        String.append "" randomlyGeneratedString
                in
                randomlyGeneratedString
                    |> Monoid.append Monoid.string ""
                    |> Expect.equal expected
        , Test.fuzz (Fuzz.list Fuzz.string) "tests that ++ equivalent to Monoid.concat for string" <|
            \randomlyGeneratedStringList ->
                let
                    expected =
                        List.foldr String.append "" randomlyGeneratedStringList
                in
                randomlyGeneratedStringList
                    |> Monoid.concat Monoid.string
                    |> Expect.equal expected
        , Test.fuzz (Fuzz.list Fuzz.int) "tests List.sum equivalent to Monoid.concat Monoid.sum " <|
            \randomlyGeneratedIntList ->
                let
                    expected =
                        Monoid.Sum <| List.sum randomlyGeneratedIntList
                in
                randomlyGeneratedIntList
                    |> List.map Monoid.Sum
                    |> Monoid.concat Monoid.sum
                    |> Expect.equal expected
        ]
