module Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Chess.Parts exposing (CanMove, Move)
import Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder CanMove
collectionDecoder =
    Decode.list moveDecoder


moveDecoder : Decode.Decoder Move
moveDecoder =
    Decode.map3 Move
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
