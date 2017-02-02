module Chess.Board exposing (Board, initBoard)

import Dict exposing (Dict(..))
import Chess.Parts exposing (part, Part, PartType(..))
import Chess.Field exposing (..)
import Chess.Color exposing (Color(..))

{- Model Field.elm -}
type alias Board = Dict String Part
{- Model Field.elm End-}

initBoard: Board
initBoard = Dict.fromList [
    (showField <| field 1 1, part Rook White),
    (showField <| field 2 1, part Knight White),
    (showField <| field 3 1, part Bishop White),
    (showField <| field 4 1, part Queen White),
    (showField <| field 5 1, part King White),
    (showField <| field 6 1, part Bishop White),
    (showField <| field 7 1, part Knight White),
    (showField <| field 8 1, part Rook White),
    (showField <| field 1 2, part Pawn White),
    (showField <| field 2 2, part Pawn White),
    (showField <| field 3 2, part Pawn White),
    (showField <| field 4 2, part Pawn White),
    (showField <| field 5 2, part Pawn White),
    (showField <| field 6 2, part Pawn White),
    (showField <| field 7 2, part Pawn White),
    (showField <| field 8 2, part Pawn White),
    (showField <| field 1 7, part Pawn Black),
    (showField <| field 2 7, part Pawn Black),
    (showField <| field 3 7, part Pawn Black),
    (showField <| field 4 7, part Pawn Black),
    (showField <| field 5 7, part Pawn Black),
    (showField <| field 6 7, part Pawn Black),
    (showField <| field 7 7, part Pawn Black),
    (showField <| field 8 7, part Pawn Black),
    (showField <| field 1 8, part Rook Black),
    (showField <| field 2 8, part Knight Black),
    (showField <| field 3 8, part Bishop Black),
    (showField <| field 4 8, part Queen Black),
    (showField <| field 5 8, part King Black),
    (showField <| field 6 8, part Bishop Black),
    (showField <| field 7 8, part Knight Black),
    (showField <| field 8 8, part Rook Black)]
