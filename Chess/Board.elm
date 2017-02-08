module Chess.Board exposing (Board, initBoard, hasAlly, findPart, updatePartPositionBoard)

import Dict exposing (..)
import Chess.Parts exposing (part, Part, PartType(..))
import Chess.Field exposing (..)
import Chess.Color exposing (Color(..))

{- Model Field.elm -}
type alias Board = Dict String Part
{- Model Field.elm End-}

initBoard: Board
initBoard = Dict.fromList [
    (showField <| field 1 1, part Rook White),
    (showField <| field 1 2, part Knight White),
    (showField <| field 1 3, part Bishop White),
    (showField <| field 1 4, part Queen White),
    (showField <| field 1 5, part King White),
    (showField <| field 1 6, part Bishop White),
    (showField <| field 1 7, part Knight White),
    (showField <| field 1 8, part Rook White),
    (showField <| field 2 1, part Pawn White),
    (showField <| field 2 2, part Pawn White),
    (showField <| field 2 3, part Pawn White),
    (showField <| field 2 4, part Pawn White),
    (showField <| field 2 5, part Pawn White),
    (showField <| field 2 6, part Pawn White),
    (showField <| field 2 7, part Pawn White),
    (showField <| field 2 8, part Pawn White),
    (showField <| field 7 1, part Pawn Black),
    (showField <| field 7 2, part Pawn Black),
    (showField <| field 7 3, part Pawn Black),
    (showField <| field 7 4, part Pawn Black),
    (showField <| field 7 5, part Pawn Black),
    (showField <| field 7 6, part Pawn Black),
    (showField <| field 7 7, part Pawn Black),
    (showField <| field 7 8, part Pawn Black),
    (showField <| field 8 1, part Rook Black),
    (showField <| field 8 2, part Knight Black),
    (showField <| field 8 3, part Bishop Black),
    (showField <| field 8 4, part Queen Black),
    (showField <| field 8 5, part King Black),
    (showField <| field 8 6, part Bishop Black),
    (showField <| field 8 7, part Knight Black),
    (showField <| field 8 8, part Rook Black)]

updatePartPositionBoard: Board -> (Int, Int, String, String) -> Board
updatePartPositionBoard board (x,y,partChar, originField) =
    let part = get (originField) board
        mog = Debug.log "----" originField
    in
        case part of
            Nothing -> board
            Just part ->
                let board1 = remove (originField) board
                in insert (showField <| field x y) part board1


findPart: Int -> Int -> Board -> Maybe Part
findPart row col board = get (showField <| field row col) board

hasAlly : Int -> Int -> Board -> Color -> Bool
hasAlly x y board color =
    let
        part = findPart x y board
    in
        case part of
        Just part ->
            let
                log = Debug.log "partColor - 1 -" part.color
                log02 = Debug.log "partColor - 2 -" color
                log2 = Debug.log "partColor - 3 -" (color == part.color)
            in
                part.color == color
        _ -> False
