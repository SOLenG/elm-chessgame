module Messages exposing (..)

import Http exposing (..)
import Models exposing (..)

type Msg
    = GameCreate
          | ClickSquare Position
          | GameSquareSelected (Result Http.Error (List Moves))
          | ClickForMove Position
