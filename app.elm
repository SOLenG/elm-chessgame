module App exposing (..)

import Html exposing (div, ul, li, button, text, Html)
import Html.Attributes exposing (style, attribute)
import Html.Attributes exposing (class)
import Html.Events exposing (onInput, onClick, targetValue)
import List exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Mouse
import Chess.Color exposing (..)
import Chess.Board exposing (..)
import Chess exposing (..)
import Messages exposing (..)
import Commands exposing (..)
import Models exposing (..)

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

init :(Model, Cmd Msg)
init  =
  ( Model 0 (Position 0 0 "" "00") (Moves "" [(Move -1 -1)]) initBoard
  , Cmd.none
  )
-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
      GameCreate ->
        ({model | stepNumber = 1}, Cmd.none)
      ClickForMove position ->
        let
            board = updatePartPositionBoard model.board (model.position.x, model.position.y, model.position.part, model.position.origin)
            log = Debug.log "UPDATE" board
        in
            ({model | position = position, stepNumber = 2, board = board}, Cmd.none)
      ClickSquare position ->
        ({model | position = position, stepNumber = 2}, (fetchMove {model | position = position, stepNumber = 2}))
      GameSquareSelected (Ok moves) ->
        let
            log = Debug.log "??" moves
            movs = fixHeadMoves moves
        in
--        ({model | stepNumber = 2, moves = moves}, Cmd.none)
        ({model | stepNumber = 2, moves = movs}, Cmd.none)
      GameSquareSelected (Err error) ->
        ({model | stepNumber = 2, position = ( Position 42 42 "Error" "42,42")}, Cmd.none)

fixHeadMoves: (List Moves) -> Moves
fixHeadMoves list =
    case list of
    (head :: tail) -> head
    _ -> (Moves "" [(Move -1 -1)])

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
--  Sub.batch
--        [ Mouse.clicks Chess.ClickSquare
--        ]

-- VIEW
view : Model -> Html Msg
view model =
  if model.stepNumber == 1 then
    board model
  else if model.stepNumber == 2 then
    board model
  else
    div []
      [ button [ onClick GameCreate ] [ text "Start" ]]


board: Model -> Html Msg
board model =
    let
        log = Debug.log "Position : " model
    in
        div [ attribute "id" "gameboard"]
        [ Chess.board config model
        ]

-- HTTP
--apiCreateGame : (Int, (Int, Int, String)) -> Cmd Msg
--apiCreateGame (stepNumber, (x,y,name)) =
--  let
--    url =
--      "http://localhost:8080/call?x=" ++ x ++ "&y=" ++ y ++ "&name=" ++ name
--  in
--    Http.send GameSquareSelected (Http.get url decodeApiResponse)
--
--
--decodeApiResponse : Decode.Decoder String
--decodeApiResponse =
--  Decode.at ["data", "image_url"] Decode.string