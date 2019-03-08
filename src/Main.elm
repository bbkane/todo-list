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


type SortOrder
    = ByContent
    | ById


type alias Item =
    { content : String }


type alias Id =
    Int


{-| For the view
-}
type alias ListItem =
    { id : Id
    , item : Item
    }


type alias Model =
    { currentInput : String
    , items : Dict.Dict Id Item
    , nextId : Id
    , sortOrder : SortOrder
    }


init : Model
init =
    { currentInput = "", items = Dict.empty, nextId = 1, sortOrder = ById }



-- Update


type Msg
    = ChangeNewInput String
    | AddNewInputToItems String
    | RemoveItem Id
    | ChangeSortOrder SortOrder


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeNewInput newContent ->
            if newContent == "" then
                model

            else
                { model | currentInput = newContent }

        AddNewInputToItems newInputItemContent ->
            { model
                | items = Dict.insert model.nextId (Item newInputItemContent) model.items
                , nextId = model.nextId + 1
                , currentInput = ""
            }

        RemoveItem id ->
            { model
                | items = Dict.remove id model.items
            }

        ChangeSortOrder newOrder ->
            { model
                | sortOrder = newOrder
            }



-- View


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "New Item", value model.currentInput, onInput ChangeNewInput ] []
        , button [ onClick (AddNewInputToItems model.currentInput) ] [ text "Submit" ]
        , button [ onClick (ChangeSortOrder ById) ] [ text "Sort By ID" ]
        , button [ onClick (ChangeSortOrder ByContent) ] [ text "Sort By Content" ]
        , renderList model.items model.sortOrder
        ]


renderList : Dict.Dict Id Item -> SortOrder -> Html Msg
renderList dct sortOrder =
    let
        lst =
            List.map (\l -> ListItem (Tuple.first l) (Tuple.second l)) (Dict.toList dct)

        -- TODO: why isn't this working?
        sortByContent listItemA listItemB =
            compare listItemA.item.content listItemB.item.content

        sortedList =
            case sortOrder of
                ById ->
                    List.sortBy .id lst

                ByContent ->
                    List.sortWith sortByContent lst
    in
    ul [] (List.map (\l -> renderItem l) sortedList)


renderItem : ListItem -> Html Msg
renderItem listItem =
    let
        makeText =
            String.fromInt listItem.id ++ " - " ++ listItem.item.content
    in
    li []
        [ text makeText
        , button [ onClick (RemoveItem listItem.id) ] [ text "Remove" ]
        ]
