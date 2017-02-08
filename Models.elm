module Models exposing (..)

import Chess.Board exposing (..)

type alias Move = { x : Int, y : Int }
type alias CanMove = {moves : (List Move)}
type alias Position = {x : Int, y : Int, part : String, origin : String}

type alias Moves = {
    part: String
    ,moves: List Move
    }
type alias Model = {
    stepNumber : Int
    , position : Position
    , moves : Moves
    , board : Board
    }
type alias Context = { model: Model, dom: Int}