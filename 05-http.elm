import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode



main =
  Html.program
    { init = init "cats"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { topic : String
  , topicInput : String
  , topicSelect : String
  , gifUrl : String
  , notice : String
  }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "" "cats" "waiting.gif" ""
  , getRandomGif topic
  )



-- UPDATE


type Msg
  = InputChange String
  | SelectChange String
  | ChangeTopic1
  | ChangeTopic2
  | MorePlease
  | NewGif (Result Http.Error String)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    InputChange newTopic->
      ({ model | topicInput = newTopic }, Cmd.none)

    ChangeTopic1 ->
      let
        topic = model.topicInput
      in
        ({ model | topic = topic }, getRandomGif topic)

    SelectChange newTopic->
      ({ model | topicSelect = newTopic }, Cmd.none)

    ChangeTopic2 ->
      let
        topic = model.topicSelect
      in
        ({ model | topic = topic }, getRandomGif topic)

    MorePlease ->
      ({ model | notice = "" }, getRandomGif model.topic)

    NewGif (Ok newUrl) ->
      ({ model | gifUrl = newUrl, notice = "" }, Cmd.none)

    NewGif (Err message) ->
      let notice = 
        case message of
          Http.BadUrl _ -> "you did not provide a valid URL"
          Http.Timeout -> "it took too long to get a response"
          Http.NetworkError -> "the user turned off their wifi, went in a cave, etc"
          Http.BadStatus statusCode -> "you got a response back with status code " ++ (toString statusCode)
          Http.BadPayload str1 str2 -> "the body of the response was something unexpected with debug message: " ++ str1 ++ " and " ++ (toString str2) 
      in  
        ({ model | notice = "err: " ++ notice }, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , input [ placeholder "enter new topic", onInput InputChange ] []
    , button [ onClick ChangeTopic1 ] [ text "Modify topic with text field" ]
    , br [] []
    , select [ on "change" (Decode.map SelectChange (targetValue |> Decode.andThen Decode.succeed))
             ] 
             [ viewOption "cats"
             , viewOption "dogs"
             , viewOption "apple"
             ]
    , button [ onClick ChangeTopic2 ] [ text "Modify topic with drop down menu" ]
    , br [] []
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [src model.gifUrl] []
    , div [] [ text model.notice ]
    ]

viewOption : String -> Html Msg
viewOption name =
  option
    [ value name ]
    [ text name ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string
