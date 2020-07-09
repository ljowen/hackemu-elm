module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, input, li, ol, pre, text)
import Html.Attributes exposing (src, value)
import Html.Events exposing (onInput)
import Array


---- MODEL ----

type alias CPU = {
  regA : String,
  regB : String  
 }

type alias Rom =
    List String

type alias Ram = Rom

type alias Model =
    { rom : Rom,
      pc: Int
    }


init : ( Model, Cmd Msg )
init =
    ( { rom = [ "abc", "fasdf", "asdf", "asdf" ], pc=0 }, Cmd.none )



---- UPDATE ----


type Msg
    = UpdateRom ( String, Int )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateRom ( newValue, updateIdx ) ->
            ( { pc = model.pc, rom = Array.toList (Array.set updateIdx newValue (Array.fromList model.rom)) }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Your Elm App is working!" ]
        , ol []
            (List.indexedMap viewRomValue model.rom)
        , pre [] (List.map (\x -> text (x ++ "\n")) model.rom)
        ]


viewRomValue : Int -> String -> Html Msg
viewRomValue romIdx romValue =
    li []
        [ input [ value romValue, onInput (\newValue -> UpdateRom (newValue, romIdx)) ] []
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
