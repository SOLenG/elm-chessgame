module Chess exposing (..)

import Html exposing (div, ul, li, text, Html)
import Html.Attributes exposing (style, class, attribute)
import Html.Events exposing (onClick)
import Chess.Color exposing (showColor, Color(White, Black, Red), oppositeColor)
import Chess.Field exposing (..)
import Chess.Board exposing (Board, initBoard)
import Chess.Parts exposing (showPart, Part, showPartChar)
import Chess.Movement exposing (canMove)
import List exposing (..)
import Dict exposing (..)
import Mouse exposing (..)
import Messages exposing (..)
import Models exposing (..)

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

board: Config -> Model ->Html Msg
board config model =
    let
        colStyle =
            ( "display", "inline-block" )
    in
        div
        [ style
            [ ( "font-size", "250%" )
            , ( "text-align", "center" )
            , ( "line-height", "1.2" )
            ]
        ]
        (board_ config 1 model config.black)
--            (concat
--                (repeat 4
--                    [ div [ style [ colStyle ] ] (concat (repeat 4 [ square config (showColor config.white ), square config (showColor config.black) ]))
--                    , div [ style [ colStyle ] ] (concat (repeat 4 [ square config (showColor config.black), square config (showColor config.white) ]))
--                    ]
--                )
--            )

board_: Config -> Int -> Model -> Color -> List(Html Msg)
board_ config position model color=
    if position < 9 then
        let
--            element = [div [ style [  ("display", "inline-block") ] ] (concat (repeat 4 [ square config (showColor config.white ), square config (showColor config.black) ]))]
            element = [div [ style [  ("display", "inline-block") ] ] (rowSquare config position 1 model color)]
            element2 = board_ config (position+1) model (oppositeColor color)
        in
            (concat [element ,element2])
    else
       [div[][]]

rowSquare: Config -> Int -> Int -> Model -> Color -> List(Html Msg)
rowSquare config col row model color =
    if row < 9 then
        let
            part = get (showField <| field row col) model.board
            element = [ square config model (showColor color) part col row]
            element2 = rowSquare config col (row+1) model (oppositeColor color)
        in
            (concat [element ,element2])
    else
       [div[][]]

square: Config -> Model -> String -> Maybe Part -> Int -> Int -> Html Msg
square config model color part col row =
        let
            cm = canMove col row model.moves model.board
            onclick = if(cm) then
                          onClick (ClickForMove ( Models.Position col row model.moves.part model.position.origin))
                      else
                          onClick (ClickSquare (Models.Position col row (showPartChar <| part) (showField <| field col row)))
        in
            div
                [ style
                    [ ( "width", (toString (fieldSize config)) ++ "px" )
                    , ( "height", (toString (fieldSize config)) ++ "px" )
                    , ( "cursor", "pointer")
                    , ( "background-color",
                    if (cm) then showColor Red else color)
                    ]
                 , attribute "title" (showField <| field col row)
                 , attribute "data-square" (showField <| field col row)
                 , attribute "data-part" (showPartChar <| part)
                 , onclick

--                 , onClick (ClickSquare (col, row, showPartChar <| part))
--                        (onClick ClickForMove (col, row, model.moves.part, showField <| field col row))

                 --, onClick [ClickSquare]
                ]
                [text (showPart part)]
