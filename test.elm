module Main exposing (..)
import Html exposing (div)
import Html
import List exposing (map)
import Svg exposing (svg)
import Svg.Events exposing (onClick)
import Svg.Attributes exposing (width, height, r, cx, cy, fill)



main =
    Html.beginnerProgram
        { model = Nothing
        , view = view
        , update = \msg _ -> msg
        }



svgCircle (xCenter, yCenter) =
    Svg.circle [ r "15"
               , fill "red"
               , cy (toString xCenter)
               , cx (toString yCenter)
               , onClick (Just (xCenter, yCenter) )
               ] []



view model =
    div []
        [ Html.text (toString model)

        , div []
              [ svg [ width "100" , height "100" ]
                    (map svgCircle [ (30, 30) , (70, 30) , (50, 60) ])
              ]
        ]