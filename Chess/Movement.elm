module Chess.Movement exposing (canMove)

import String exposing (cons, fromChar)
import Char exposing (fromCode)
import Chess.Color exposing (Color(..))
import Chess.Board exposing (..)
import Chess.Parts exposing (..)
import Models exposing (..)

-- Moves
directionsB = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
directionsR = [(0, 1), (0, -1), (1, 0), (-1, 0)]
directionsN = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)]
directionsQ = directionsR ++ directionsB

canMove : Int -> Int -> Moves -> Board -> Bool
canMove x y moves board =
--    let log = Debug.log "test" (moves, x, y)
--    in
    let
        partColor = getColorByChar moves.part
--        log = Debug.log "partColor" partColor
    in
        canMove_ x y moves.moves board partColor

canMove_ : Int -> Int -> List Move -> Board -> Color -> Bool
canMove_ x y moves board color =
    case moves of
    (head :: tail) ->
        if (head.x == x && head.y == y && (False == (hasAlly x y board color)) ) then
            True
        else
            canMove_ x y tail board color
    _ -> False