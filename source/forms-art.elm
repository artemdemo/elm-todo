import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , validInput : Bool
  }


model : Model
model = Model "" "" "" True


-- UPDATE

type Msg
    = Name String | Password String | PasswordAgain String | ValidInput


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    ValidInput ->
      { model | validInput = (String.length model.password > 7
                              && model.password == model.passwordAgain) }



-- VIEW

view : Model -> Html Msg
view model =
  div [ style [("padding", "50px")] ]
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , button [ onClick ValidInput ] [ text "Let go" ]
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.validInput then
        ("green", "OK")
      else
        ("red", "Content is not valid")
  in
    div [ style [("color", color)] ] [ text message ]
