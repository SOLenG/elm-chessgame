module Main exposing (..)
import Html exposing (Html, div)
import Html.Attributes
import Html.Events exposing (on)
import Json.Decode as Json exposing (..)
import Svg exposing (svg, rect)
import Svg.Attributes exposing (..)
import VirtualDom

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

type alias Position =
    { x : Int
    , y : Int
    }

type alias Model =
  Position

type Msg
  = ChangePosition Position

model : Model
model =
  Position 0 0

update : Msg -> Model -> Model
update msg _ =
  case Debug.log "msg" msg of
    ChangePosition position ->
      position

view : Model -> Html Msg
view model =
  div []
    [ svg
        [ width "400"
        , height "100"
        , viewBox "0 0 400 100"
        ]
        [ rect
            [ onClickLocation -- this should work but does nothing
            , width "400"
            , height "100"
            , x "0"
            , y "0"
            , fill "#000"
            , cursor "pointer"
            ]
            []
        , rect
            [ width "50"
            , height "50"
            , x (toString model.x)
            , y "20"
            , fill "#fff"
            ]
            []
        ]
    , div
        [ onClickLocation -- this works
        , Html.Attributes.style
            [ ( "background-color", "white" )
            , ( "border", "2px solid black" )
            , ( "width", "400px" )
            , ( "height", "100px" )
            , ( "position", "absolute" )
            , ( "left", "0px" )
            , ( "top", "150px" )
            , ( "color", "black" )
            , ( "cursor", "pointer" )
            ]
        ]
        [ div [] [ Html.text "Click in here to move x position of white svg square. Relative click coordinates shown below (y coordinate ignored)." ]
        , div [] [ Html.text (toString model) ]
        ]
    ]

onClickLocation : Html.Attribute Msg
onClickLocation =
    mouseClick ChangePosition


offsetPosition : Json.Decoder Position
offsetPosition =
    Json.map2 Position (field "pageX" Json.int) (field "pageY" Json.int)


mouseEvent : String -> (Position -> msg) -> VirtualDom.Property msg
mouseEvent event messager =
    let
        options =
            { preventDefault = True, stopPropagation = True }
    in
        VirtualDom.onWithOptions event options (Json.map messager offsetPosition)


mouseClick : (Position -> msg) -> VirtualDom.Property msg
mouseClick =
    mouseEvent "click"