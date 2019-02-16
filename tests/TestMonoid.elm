module TestMonoid exposing (suite)

import Expect
import Fuzz
import Monoid
import Test


suite : Test.Test
suite =
    Test.describe "The Monoid module"
        [ Test.fuzz (Fuzz.list Fuzz.string) "tests that ++ equivalent to Monoid.concat for string" <|
            \randomlyGeneratedStringList ->
                let
                    expected : String
                    expected =
                        List.foldr (++) "" randomlyGeneratedStringList
                in
                randomlyGeneratedStringList
                    |> Monoid.concat Monoid.string
                    |> Expect.equal expected
        ]
