module Chess.Parts exposing (part, Part, PartType(..), showPart, showPartChar, getColorByChar)

import String exposing (cons, fromChar)
import Char exposing (fromCode)
import Chess.Color exposing (Color(..))

{- Parts.elm type -}
type PartType = King | Queen | Rook | Bishop | Knight | Pawn

{- Model Parts.elm -}
type alias Part = { model : PartType, color : Color }
part : PartType -> Color -> Part
part partsType color = { model = partsType, color = color }
{- Model Parts.elm End-}

{- Show Chess Parts.elm symbols in Unicode -}
getUnicodeWhiteParts : PartType -> Char.KeyCode
getUnicodeWhiteParts model =
    case model of
        King   -> 9818
        Queen  -> 9819
        Rook   -> 9820
        Bishop -> 9821
        Knight -> 9822
        Pawn   -> 9823

getUnicodeBlackParts : PartType -> Char.KeyCode
getUnicodeBlackParts model =
    case model of
        King   -> 9812
        Queen  -> 9813
        Rook   -> 9814
        Bishop -> 9815
        Knight -> 9816
        Pawn   -> 9817
{- Returns the Chess symbols in Unicode -}
showPart__ : PartType -> Color -> Char.KeyCode
showPart__ model color =
    case color of
        White -> getUnicodeWhiteParts model
        Black -> getUnicodeBlackParts model
        _ -> 0

showPart_ : Part -> String
showPart_ {model, color} =
    let symbol = showPart__ model color
    in cons (fromCode symbol) ""
showPart : Maybe Part -> String
showPart part =
    case part of
    Nothing -> "." -- cons (fromCode 0020) ""
    Just part -> showPart_ part


{- Show Chess Parts.elm symbols in Char -}
getCharWhiteParts : PartType -> String
getCharWhiteParts model =
    case model of
        King   -> "k"
        Queen  -> "q"
        Rook   -> "r"
        Bishop -> "b"
        Knight -> "n"
        Pawn   -> "p"

getCharBlackParts : PartType -> String
getCharBlackParts model =
    case model of
        King   -> "K"
        Queen  -> "Q"
        Rook   -> "R"
        Bishop -> "B"
        Knight -> "N"
        Pawn   -> "P"

{- Returns the Chess symbols in Unicode -}
showPartChar_ : Part -> String
showPartChar_ {model, color} =
    case color of
        White -> getCharWhiteParts model
        Black -> getCharBlackParts model
        _ -> ""
showPartChar : Maybe Part -> String
showPartChar part =
    case part of
    Nothing -> "." -- cons (fromCode 0020) ""
    Just part -> showPartChar_ part

getColorByChar : String -> Color
getColorByChar partChar =
    case partChar of
         "k" -> Black
         "q" -> Black
         "r" -> Black
         "b" -> Black
         "n" -> Black
         "p" -> Black
         "K" -> White
         "Q" -> White
         "R" -> White
         "B" -> White
         "N" -> White
         "P" -> White
         _ -> Red
