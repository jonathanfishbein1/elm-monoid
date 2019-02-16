module TestMonoid exposing (suite)

import Expect
import Fuzz
import Monoid
import Test


suite : Test.Test
suite =
    Test.describe "The String module"
        [ Test.fuzz Fuzz.string "restores the original string if you run it again" <|
            \randomlyGeneratedString ->
                randomlyGeneratedString
                    |> String.reverse
                    |> String.reverse
                    |> Expect.equal randomlyGeneratedString
        ]
