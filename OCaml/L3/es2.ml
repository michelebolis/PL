(*
Beyond the well-known Celsius and Fahrenheit, there are other six temperature scales: Kelvin, Rankine, Delisle, Newton, Réaumur, and Rømer 
(Look at:
http://en.wikipedia.org/wiki/Comparison_of_temperature_scales
to read about them).

Write a function that given a pure number returns a conversion table for it among any of the 8 scales.
Write a function that given a temperature in a specified scale returns a list of all the corresponding temperatures in the other scales, 
note that the scale must be specified.
Hint. Define a proper datatype for the temperature.   
*)

type scale = Kelvin | Celsius | Fahrenheit | Rankine | Delisle | Newton | Reaumur | Romer ;;
type temperature = {temp : float; scala : scale};;

let t1 = {temp= 0.0; scala= Kelvin};;
let convert t scalaDesiderata =
  if (t.scala==scalaDesiderata) then
    t 
  else
  let rec changeScale t = 
    match t.scala with
    | Kelvin -> changeScale {temp= t.temp -. 273.15; scala= Celsius}
    | Fahrenheit -> changeScale {temp= ((t.temp -. 32.0) *. (5.0/.9.0)); scala= Celsius}
    | Rankine -> changeScale {temp= ((t.temp-.491.67)*.(5.0/.9.0)); scala= Celsius}
    | Delisle -> changeScale {temp= ((100.0-.t.temp*.(2.0/.3.0))); scala= Celsius}
    | Newton -> changeScale {temp= (t.temp*.(100.0/.33.0)); scala= Celsius}
    | Reaumur -> changeScale {temp= (t.temp*.(5.0/.4.0)); scala= Celsius}
    | Romer -> changeScale {temp= (t.temp-.7.5)*.(40.0/.21.0); scala= Celsius}
    | Celsius -> 
        (match scalaDesiderata with 
          Kelvin -> {temp= t.temp +. 273.15; scala= Kelvin}
        | Fahrenheit -> {temp= (t.temp *. (9.0/.5.0) +. 32.0); scala= Fahrenheit}
        | Rankine ->{temp= (t.temp +. 273.15) *. (9.0/.5.0); scala= Rankine}
        | Delisle -> {temp= (100.0 -. t.temp) *. (3.0/.2.0); scala= Delisle}
        | Newton -> {temp= (t.temp *. (33.0/.100.0)); scala= Newton}
        | Reaumur -> {temp= (t.temp *. (4.0/.5.0)); scala= Reaumur}
        | Romer -> {temp= (t.temp *. (21.0/.40.0) +. 7.5); scala= Romer}
        | Celsius -> t
        )
  in changeScale t ;;
;;
convert t1 Celsius;;
let convert_to_all t = [(convert t Kelvin); (convert t Celsius); (convert t Fahrenheit); (convert t Rankine); (convert t Delisle); (convert t Newton); (convert t Reaumur); (convert t Romer)];;
convert_to_all t1;;