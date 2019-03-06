module Main exposing (Item, main)

import Browser
import Html exposing (Attribute, Html, button, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Item =
    { content : String }


type alias Model =
    { currentInput : String
    , items : List Item
    , nextId : Int
    }


init : Model
init =
    { currentInput = "", items = [], nextId = 1 }



-- Update


type Msg
    = ChangeCurrentInput String
    | AddInputToInputs String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeCurrentInput newContent ->
            { model | currentInput = newContent }

        AddInputToInputs newInputItemContent ->
            { model
                | items = Item newInputItemContent :: model.items
                , nextId = model.nextId + 1
            }



-- View


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.currentInput, onInput ChangeCurrentInput ] []
        , div [] [ text (String.reverse model.currentInput) ]
        , button [ onClick (AddInputToInputs model.currentInput) ] [ text "Submit" ]
        , renderList model.items
        ]


renderList : List Item -> Html Msg
renderList lst =
    ul [] (List.map (\l -> li [] [ text l.content ]) lst)
