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

let t1 = {temp= 2.0; scala= Celsius};;
let convert t scalaDesiderata =
  if (t.scala==scalaDesiderata) then
    t 
  else
  let rec changeScale t = 
    match t.scala with
    | Kelvin -> {temp= 0.0; scala= Celsius}
    | Fahrenheit -> {temp= 0.0; scala= Celsius}
    | Rankine ->{temp= 0.0; scala= Celsius}
    | Delisle -> {temp= 0.0; scala= Celsius}
    | Newton -> {temp= 0.0; scala= Celsius}
    | Reaumur -> {temp= 0.0; scala= Celsius}
    | Romer -> {temp= 0.0; scala= Celsius}
    | Celsius -> 
        (match scalaDesiderata with 
          Kelvin -> {temp= t.temp +. 273.15; scala= Kelvin}
        | Fahrenheit -> {temp= 0.0; scala= Celsius}
        | Rankine ->{temp= 0.0; scala= Celsius}
        | Delisle -> {temp= 0.0; scala= Celsius}
        | Newton -> {temp= 0.0; scala= Celsius}
        | Reaumur -> {temp= 0.0; scala= Celsius}
        | Romer -> {temp= 0.0; scala= Celsius}
        | Celsius -> t
        )
  in changeScale t ;;
;;
convert t1 Celsius;;