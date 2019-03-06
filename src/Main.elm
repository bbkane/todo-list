module Main exposing (Item, main)

import Browser
import Dict
import Html exposing (Attribute, Html, button, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List
import String
import Tuple


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Item =
    { content : String }


type alias Id =
    Int


type alias Model =
    { currentInput : String
    , items : Dict.Dict Id Item
    , nextId : Id
    }


init : Model
init =
    { currentInput = "", items = Dict.empty, nextId = 1 }



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
                | items = Dict.insert model.nextId (Item newInputItemContent) model.items
                , nextId = model.nextId + 1
            }



-- View


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.currentInput, onInput ChangeCurrentInput ] []
        , button [ onClick (AddInputToInputs model.currentInput) ] [ text "Submit" ]
        , renderList model.items
        ]


renderList : Dict.Dict Id Item -> Html Msg
renderList dct =
    let
        lst =
            Dict.toList dct

        makeText l =
            String.fromInt (Tuple.first l) ++ " - " ++ (Tuple.second l).content
    in
    ul [] (List.map (\l -> li [] [ text (makeText l) ]) lst)
