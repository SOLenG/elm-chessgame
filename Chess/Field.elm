module Chess.Field exposing (..)

import Char exposing (fromCode)
import String exposing (concat)

{- Model Field.elm -}
type alias Field = { col: Int, row: Int}
field: Int -> Int -> Field
field c r = { col= c, row= r }
{- Model Field.elm End-}

showField: Field -> String
showField {col, row} = concat [toString (fromCode (64+col)), toString row]
