module Chess exposing (..)

import Html exposing (div, ul, li, text, Html)
import Html.Attributes exposing (style, class, attribute)
import Chess.Color exposing (showColor, Color(White, Black), oppositeColor)
import Chess.Field exposing (..)
import Chess.Board exposing (Board, initBoard)
import Chess.Parts exposing (showPart, Part, showPartChar)
import List exposing (..)
import Dict exposing (..)

{- config -}
type alias Config = { size: Int, white : Color, black : Color}
defaultConfig: Config
defaultConfig =
      { size = 900
      , white = White
      , black = Black
      }

newConfig : Int -> Color -> Color -> Config
newConfig tileSize white black =
    { size = tileSize
    , white = white
    , black = black
    }

{- div by 9 to show col and row label -}
fieldSize : Config -> Float
fieldSize config = toFloat config.size / 9

type alias Counter = {tile : Int}
initCounter : Counter
initCounter = {tile = 0}
counter = initCounter

board: Config -> Html msg
board config =
    let
        colStyle =
            ( "display", "inline-block" )
    in
        div []
            [
            div
            [ style
                [ ( "font-size", "250%" )
                , ( "text-align", "center" )
                , ( "line-height", "1.2" )
                ]
            ]
            (board_ config 1 initBoard config.black)
--            (concat
--                (repeat 4
--                    [ div [ style [ colStyle ] ] (concat (repeat 4 [ square config (showColor config.white ), square config (showColor config.black) ]))
--                    , div [ style [ colStyle ] ] (concat (repeat 4 [ square config (showColor config.black), square config (showColor config.white) ]))
--                    ]
--                )
--            )
            ]

board_: Config -> Int -> Board -> Color -> List (Html msg)
board_ config position dicBoard color=
    if position < 9 then
        let
--            element = [div [ style [  ("display", "inline-block") ] ] (concat (repeat 4 [ square config (showColor config.white ), square config (showColor config.black) ]))]
            element = [div [ style [  ("display", "inline-block") ] ] (rowSquare config position 1 dicBoard color)]
            element2 = board_ config (position+1) dicBoard (oppositeColor color)
        in
            (concat [element ,element2])
    else
       [div[][]]

rowSquare: Config -> Int -> Int -> Board -> Color -> List(Html msg)
rowSquare config col row dicBoard color =
    if row < 9 then
        let
            part = get (showField <| field row col) dicBoard
            element = [ square config (showColor color) part col row]
            element2 = rowSquare config col (row+1) dicBoard (oppositeColor color)
        in
            (concat [element ,element2])
    else
       [div[][]]

square: Config -> String -> Maybe Part -> Int -> Int -> Html msg
square config color part col row =
        div
            [ style
                [ ( "width", (toString (fieldSize config)) ++ "px" )
                , ( "height", (toString (fieldSize config)) ++ "px" )
                , ( "background-color", color )
                ]
             , attribute "data-square" (showField <| field col row)
             , attribute "data-part" (showPartChar <| part)
            ]
            [text (showPart part)]
