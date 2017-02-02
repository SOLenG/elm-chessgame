module Chess.Color exposing (showColor, Color(White, Black), oppositeColor)

--import Maybe

{- config -}
type alias Config = { white : String, black : String}
defaultConfig: Config
defaultConfig =
      { white = "white"
      , black = "silver"
      }

type Color = White | Black

showColor: Color -> String
showColor color =
    showColor_ defaultConfig color

--showColor: Color -> Maybe Config -> String
--showColor color config = case config of
--    Just config -> showColor_ config color
--    Nothing -> showColor_ defaultConfig color

showColor_: Config -> Color -> String
showColor_ config color = case color of
    White -> config.white
    Black -> config.black

oppositeColor: Color -> Color
oppositeColor color =
    case color of
      White -> Black
      Black -> White
