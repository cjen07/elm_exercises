import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Regex
import Result


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , age : String
  , password : String
  , passwordAgain : String
  , hidden : Bool
  }


model : Model
model =
  Model "" "" "" "" True



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String
    | Submit


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name, hidden = True }

    Age age ->
      { model | age = age, hidden = True }

    Password password ->
      { model | password = password, hidden = True }

    PasswordAgain password ->
      { model | passwordAgain = password, hidden = True }

    Submit ->
      { model | hidden = False }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "number", placeholder "Age", onInput Age ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , button [ onClick Submit ] [ text "Submit" ]
    , viewValidation model
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if String.isEmpty model.name then
        ("red", "Name must not be empty")
      else
        case String.toInt model.age of
          Err _ -> ("red", "Age must be a number!")
          Ok age -> 
            if age <= 0 then
              ("red", "Age must be a positive number")
            else if String.length model.password < 9 then
              ("red", "Password must be longer than 8 characters!")
            else if Regex.contains (Regex.regex "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)") model.password == False then
              ("red", "Password must contain upper case, lower case, and numeric characters")
            else if model.password == model.passwordAgain then
              ("green", "OK")
            else
              ("red", "Passwords do not match!")
  in
    div [ style [("color", color)], hidden model.hidden ] [ text message ]
