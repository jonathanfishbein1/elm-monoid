module TestMonoid exposing (suite)

import Expect
import Fuzz
import Monoid
import Test


suite : Test.Test
suite =
    Test.describe "The Monoid module"
        [ Test.fuzz Fuzz.string "tests left identity value string" <|
            \stringOne ->
                let
                    identityAppend =
                        Monoid.append Monoid.string (Monoid.empty Monoid.string) stringOne
                in
                Expect.equal identityAppend stringOne
        , Test.fuzz Fuzz.string "tests right identity value string" <|
            \stringOne ->
                let
                    identityAppend =
                        Monoid.append Monoid.string stringOne (Monoid.empty Monoid.string)
                in
                Expect.equal identityAppend stringOne
        , Test.fuzz Fuzz.int "tests left identity value sum" <|
            \one ->
                let
                    identityAppend =
                        Monoid.append Monoid.sum (Monoid.empty Monoid.sum) (Monoid.Sum one)
                in
                Expect.equal identityAppend (Monoid.Sum one)
        , Test.fuzz Fuzz.int "tests right identity value sum" <|
            \one ->
                let
                    identityAppend =
                        Monoid.append Monoid.sum (Monoid.Sum one) (Monoid.empty Monoid.sum)
                in
                Expect.equal identityAppend (Monoid.Sum one)
        , Test.fuzz Fuzz.int "tests left identity value product" <|
            \one ->
                let
                    identityAppend =
                        Monoid.append Monoid.product (Monoid.empty Monoid.product) (Monoid.Product one)
                in
                Expect.equal identityAppend (Monoid.Product one)
        , Test.fuzz Fuzz.int "tests right identity value product" <|
            \one ->
                let
                    identityAppend =
                        Monoid.append Monoid.product (Monoid.Product one) (Monoid.empty Monoid.product)
                in
                Expect.equal identityAppend (Monoid.Product one)
        , Test.fuzz (Fuzz.list Fuzz.int) "tests left identity value list" <|
            \listOne ->
                let
                    identityAppend =
                        Monoid.append Monoid.list (Monoid.empty Monoid.list) listOne
                in
                Expect.equal identityAppend listOne
        , Test.fuzz (Fuzz.list Fuzz.int) "tests right identity value list" <|
            \listOne ->
                let
                    identityAppend =
                        Monoid.append Monoid.list listOne (Monoid.empty Monoid.list)
                in
                Expect.equal identityAppend listOne
        , Test.fuzz (Fuzz.array Fuzz.int) "tests left identity value array" <|
            \arrayOne ->
                let
                    identityAppend =
                        Monoid.append Monoid.array (Monoid.empty Monoid.array) arrayOne
                in
                Expect.equal identityAppend arrayOne
        , Test.fuzz (Fuzz.array Fuzz.int) "tests right identity value array" <|
            \arrayOne ->
                let
                    identityAppend =
                        Monoid.append Monoid.array arrayOne (Monoid.empty Monoid.array)
                in
                Expect.equal identityAppend arrayOne
        ]
