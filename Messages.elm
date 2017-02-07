module Messages exposing (..)

import Chess.Parts exposing (CanMove, Move)

type Msg
    = MovePart
          | ClickSquare (Int, Int, String)
          | GameCreate
          | GameSquareSelected (Result Http.Error CanMove)
