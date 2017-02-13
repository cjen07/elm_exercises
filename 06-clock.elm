import Html exposing (Html, button, div, br)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Date



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { time : Time
  , flag : Bool
  }

init : (Model, Cmd Msg)
init =
  (Model 0 False, Cmd.none)



-- UPDATE


type Msg
  = Tick Time
  | Click


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | time = newTime }, Cmd.none)
    Click ->
      ({ model | flag = not model.flag }, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  if model.flag then
    Sub.none
  else
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
  let
    angle1 =
      turns (Time.inMinutes model.time)

    handX1 =
      toString (50 + 40 * sin angle1)

    handY1 =
      toString (50 - 40 * cos angle1)

    angle2 = 
      turns (Time.inHours model.time)

    handX2 =
      toString (50 + 30 * sin angle2)

    handY2 =
      toString (50 - 30 * cos angle2)

    angle3 = 
      turns
        (((toFloat <| rem (Date.hour <| Date.fromTime model.time) 12) 
        + (toFloat <| Date.minute <| Date.fromTime model.time) / 60
        + (toFloat <| Date.second <| Date.fromTime model.time) / 3600) / 12)

    handX3 =
      toString (50 + 20 * sin angle3)

    handY3 =
      toString (50 - 20 * cos angle3)
  in
    div []
      [ svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", y1 "50", x2 handX1, y2 handY1, stroke "#023963" ] []
            , line [ x1 "50", y1 "50", x2 handX2, y2 handY2, stroke "#023963" ] []
            , line [ x1 "50", y1 "50", x2 handX3, y2 handY3, stroke "#023963" ] []
            ]
      , br [] []
      , button [ onClick Click ] [ buttonText model ]
      , div [] [ Html.text <| toString <| Date.fromTime model.time]
      ]

buttonText : Model -> Html msg
buttonText model = 
  if model.flag then
    Html.text "Continue"
  else
    Html.text "Stop"
