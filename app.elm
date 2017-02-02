module App exposing (..)

import Html exposing (div, ul, li, button, text, Html)
import Html.Attributes exposing (style)
import Html.Attributes exposing (class)
import Html.Events exposing (onInput, onClick)
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
init :(Model, Cmd Msg)
init  =
  ( Model 0
  , Cmd.none
  )
-- UPDATE
type Msg
    = GameCreated (Result Http.Error String)
    | GameCreate

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
      GameCreate ->
        (Model 1, Cmd.none)

      GameCreated (Ok newUrl) ->
        (model, Cmd.none)

      GameCreated (Err _) ->
        (model, Cmd.none)
-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  if model.stepNumber == 1 then
    board
  else
    div []
      [ button [ onClick GameCreate ] [ text "Start" ]]

startGame = div []
    [board
    ]
board = div []
        [ Chess.board config
        ]
