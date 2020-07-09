module Rom exposing (..)

import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (class, src)



-- Model


type alias Model =
    {}



-- Update


type Msg
    = NoOp


view : Model -> Html Msg
view model =
    div [ class "rom" ]
        [ h1 [] [ text "ROM" ]
        ]
