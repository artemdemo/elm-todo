import Html exposing (Html, Attribute, div, input, button, ul, li, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- MODEL

type alias AppTask =
  { id : Int
  , name : String
  }

type alias Model =
  { newTask : String
  , tasks : List AppTask
  }

model : Model
model =
  { newTask = ""
  , tasks = []
  }

-- UPDATE

type Msg
  = Change String
  | AddTask
  | RemoveTask AppTask

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | newTask = newContent }

    AddTask ->
      { model | tasks = {name = model.newTask, id = List.length model.tasks} :: model.tasks }

    RemoveTask task ->
      { model | tasks = List.filter (\item  -> item.id /= task.id) model.tasks }

-- VIEW

view : Model -> Html Msg
view model =
  div [ style
        [ ("margin", "150px auto")
        , ("width", "200px")
        , ("transform", "scale(1.75)")
        ]
      ]
    [ input [ placeholder "New task", onInput Change ] []
    , button [ onClick AddTask ] [text "add"]
    , listView model
    ]

listView : Model -> Html Msg
listView model =
  ul []
    (List.map (\task -> li []
      [ text task.name
      , button [ onClick (RemoveTask task) ] [ text "-"]
      ]) model.tasks)

-- MAIN

main =
    Html.beginnerProgram {
      model = model
      , view = view
      , update = update
    }
