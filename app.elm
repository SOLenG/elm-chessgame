module App exposing (..)

import Html exposing (div, ul, li, button, text, Html)
import Html.Attributes exposing (style, attribute)
import Html.Attributes exposing (class)
import Html.Events exposing (onInput, onClick, targetValue)
import List exposing (..)
import Http
import Chess.Color exposing (..)
import Chess exposing (..)

{- Config-}
--config = Chess.defaultConfig
config = Chess.newConfig 500 White Black
counter = Chess.initCounter

main =
    Html.program
      { init = init
      , view = view
      , update = update
      , subscriptions = subscriptions
      }
type alias Model = {
    stepNumber : Int
    }
type alias Context = { model: Model, dom: Int}

init :(Model, Cmd Msg)
init  =
  ( Model 0
  , Cmd.none
  )
-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
      Chess.GameCreate ->
        (Model 1, Cmd.none)
      Chess.ClickSquare ->
        (Model 2, Cmd.none)
      Chess.MovePart ->
        (model, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW
view : Model -> Html Msg
view model =
  if model.stepNumber == 1 then
    board
  else if model.stepNumber == 2 then
    move model
  else
    div []
      [ button [ onClick GameCreate ] [ text "Start" ]]

board = div [ attribute "id" "gameboard"]
        [ Chess.board config
        ]
move: Model -> Html Msg
move model =
    Debug.log model
    div [ attribute "id" "gameboard"]
        [ Chess.board config
        ]
