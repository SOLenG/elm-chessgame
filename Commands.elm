module Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Messages exposing (..)
import Models exposing (..)
import String exposing (cons, fromChar)


fetchMove : Model -> Cmd Msg
fetchMove model =
    Http.get (urlMove model.position) collectionDecoder
        |> Http.send GameSquareSelected

urlMove : Position -> String
urlMove position =
    let
        url = urlBase  ++ "?x=" ++ (position.x |> toString) ++ "&y=" ++ (position.y |> toString) ++ "&name=" ++ position.part
        log = Debug.log "value send" (position.x,position.y,position.part, url)
    in
        url

urlBase : String
urlBase =
    "http://localhost:8080/call"

collectionDecoder : Decode.Decoder (List Moves)
collectionDecoder =
    Decode.list movesDecoder

movesDecoder : Decode.Decoder Moves
movesDecoder =
    Decode.map2 Moves
        (field "Item2" Decode.string)
        (field "Item1" collectionMoveDecoder)

collectionMoveDecoder : Decode.Decoder (List Move)
collectionMoveDecoder =
    Decode.list moveDecoder

moveDecoder : Decode.Decoder Move
moveDecoder =
    Decode.map2 Move
        (field "Item1" Decode.int)
        (field "Item2" Decode.int)
