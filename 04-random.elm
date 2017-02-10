import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Random
import List



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFace1 : Int
  , dieFace2 : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFace (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))

    NewFace (newFace1, newFace2) ->
      (Model newFace1 newFace2, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ Html.text (toString model.dieFace1) ]
    , h1 [] [ Html.text (toString model.dieFace2) ]
    , img [ mySrc model.dieFace1, myStyle ] []
    , br [] []
    , img [ mySrc model.dieFace2, myStyle ] []
    , br [] []
    , dieSvg model.dieFace1
    , br [] []
    , dieSvg model.dieFace2 
    , br [] []
    , button [ onClick Roll ] [ Html.text "Roll" ]
    ]

mySrc : Int -> Html.Attribute msg
mySrc dieFace = 
  src ("./img/" ++ (toString dieFace) ++ ".png")

myStyle : Html.Attribute msg
myStyle =
  Html.Attributes.style
    [ ("height", "70px")
    , ("width", "70px")
    , ("padding-left", "5px")
    ]

dieSvg : Int -> Html msg
dieSvg dieFace = 
  let
    circles = 
      case dieFace of
        1 -> [ circle [ cx "40", cy "40", r "5" ] [] ]
        2 -> [ circle [ cx "20", cy "20", r "5" ] []
             , circle [ cx "60", cy "60", r "5" ] []
             ]
        3 -> [ circle [ cx "20", cy "20", r "5" ] []
             , circle [ cx "40", cy "40", r "5" ] []
             , circle [ cx "60", cy "60", r "5" ] []
             ]
        4 -> [ circle [ cx "20", cy "20", r "5" ] []
             , circle [ cx "20", cy "60", r "5" ] []
             , circle [ cx "60", cy "20", r "5" ] []
             , circle [ cx "60", cy "60", r "5" ] []
             ]
        5 -> [ circle [ cx "20", cy "20", r "5" ] []
             , circle [ cx "20", cy "60", r "5" ] []
             , circle [ cx "60", cy "20", r "5" ] []
             , circle [ cx "60", cy "60", r "5" ] []
             , circle [ cx "40", cy "40", r "5" ] []
             ]
        6 -> [ circle [ cx "20", cy "20", r "5" ] []
             , circle [ cx "40", cy "20", r "5" ] []
             , circle [ cx "60", cy "20", r "5" ] []
             , circle [ cx "20", cy "60", r "5" ] []
             , circle [ cx "40", cy "60", r "5" ] []
             , circle [ cx "60", cy "60", r "5" ] []
             ]
        _ -> []
  in 
    svg
      [ Svg.Attributes.width "80", Svg.Attributes.height "80", Svg.Attributes.viewBox "0 0 80 80" ]
      ( List.append
          [ Svg.path [ d "M15,5 h50 a10,10 0 0 1 10,10 v50 a10,10 0 0 1 -10,10 h-50 a10,10 0 0 1 -10,-10 v-50 a10,10 0 0 1 10,-10 z"
                     , fill "none"
                     , stroke "black"
                     , strokeWidth "2"
                     ] []
          ]
          circles
      )
