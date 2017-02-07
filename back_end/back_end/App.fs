

open Suave
open Suave.Web
open Suave.Filters
open Suave.Operators
open Suave.Successful
open Suave.RequestErrors
open System.Collections.Generic
open Newtonsoft.Json
open Newtonsoft.Json.Serialization
[<EntryPoint>]
let main argv =


    let directionsB (x,y) = [|(x + 1,y + 1); (x + 1, y - 1); (x - 1,y + 1); (x - 1, y - 1)|] |> Array.toList
    let directionsR (x,y) = [|(x + 0, y + 1); (x + 0, y-1); (x+1, y+0); (x-1, y+0)|] |> Array.toList
    let directionsN (x,y) = [|(x-2, y-1); (x-2, y+1); (x-1, y-2); (x-1, y+2); (x+1, y-2); (x+1, y+2); (x+2, y-1); (x+2, y+1)|] |> Array.toList
    let directionsQ (x,y) = List.append (directionsR(x,y)) (directionsB(x,y))
    
   
    let analyse (x: int,y: int,t) = match t with
        | "b" -> Newtonsoft.Json.JsonConvert.SerializeObject(directionsB(x,y):> obj)
        | "r" -> Newtonsoft.Json.JsonConvert.SerializeObject(directionsR(x,y):> obj)
        | "n" -> Newtonsoft.Json.JsonConvert.SerializeObject(directionsN(x,y):> obj)
        | "q" -> Newtonsoft.Json.JsonConvert.SerializeObject(directionsQ(x,y):> obj)
        | _ -> "OK"


   // let createJson:string = { directionsB(0,1):> obj }
    let json:string = Newtonsoft.Json.JsonConvert.SerializeObject(directionsB(0,1):> obj)
    let browse =
        request (fun r ->
            match r.queryParam "x" with
            | Choice1Of2 a  -> 
                match r.queryParam "y" with
                | Choice1Of2 b ->
                    match r.queryParam "name" with
                        | Choice1Of2 c ->  OK  (analyse(a |> int,b |> int,c))
                        | Choice2Of2 msg -> BAD_REQUEST msg
                | Choice2Of2 msg -> BAD_REQUEST msg
            | Choice2Of2 msg -> BAD_REQUEST msg)
 
    let app =
        choose
           [ GET >=> choose
               [ path "/call" >=> browse ]
           ]
 
   
    startWebServer defaultConfig app
 
    0 // return an integer exit code
