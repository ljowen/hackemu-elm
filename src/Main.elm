module Main exposing (..)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src, value)
import Html.Events exposing (onClick, onInput)
import List exposing (length)
import String



---- MODEL ----


type alias CPU =
    { regA : String
    , regB : String
    }


type alias Rom =
    List String


type alias Ram =
    Rom


type alias Model =
    { rom : Rom
    , pc : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { rom = [ "abc", "fasdf", "asdf", "asdf" ], pc = 0 }, Cmd.none )



---- UPDATE ----


type Msg
    = UpdateRom ( String, Int )
    | IncrementPC


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateRom ( newValue, updateIdx ) ->
             ( { model | rom = Array.toList (Array.set updateIdx newValue (Array.fromList model.rom)) }, Cmd.none )

        IncrementPC ->
            ( { model
                | pc =
                    if model.pc < (length model.rom - 1) then
                        model.pc + 1

                    else
                        0
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "ROM" ]
        , ol []
            (List.indexedMap (\index value -> viewRomValue index value (index == model.pc)) model.rom)
        , pre [] (List.map (\x -> text (x ++ "\n")) model.rom)
        , pre [] [ text (String.fromInt model.pc) ]
        , button [ onClick IncrementPC ] [ text ">" ]
        ]


viewRomValue : Int -> String -> Bool -> Html Msg
viewRomValue romIdx romValue currentInstruction =
    li
        [ class
            (if currentInstruction then
                "active"

             else
                ""
            )
        ]
        [ input [ value romValue, onInput (\newValue -> UpdateRom ( newValue, romIdx )) ] []
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
