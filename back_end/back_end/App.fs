open Suave
open Suave.Web
open Suave.Filters
open Suave.Operators
open Suave.Successful
open Suave.RequestErrors
open System
open System.Collections.Generic
open Newtonsoft.Json
open Newtonsoft.Json.Serialization

[<EntryPoint>]
let main argv =

    let (|InvariantEqual|_|) (str:string) arg = 
      if String.Compare(str, arg, StringComparison.OrdinalIgnoreCase) = 0
        then Some() else None

    let directionsB (x,y) = [(x + 1,y + 1); (x + 1, y - 1); (x - 1,y + 1); (x - 1, y - 1)]
    let directionsR (x,y) = [(x + 0, y + 1); (x + 0, y-1); (x+1, y+0); (x-1, y+0)]
    let directionsN (x,y) = [(x-2, y-1); (x-2, y+1); (x-1, y-2); (x-1, y+2); (x+1, y-2); (x+1, y+2); (x+2, y-1); (x+2, y+1)]
    let directionsQ (x,y) = (directionsR(x,y)) @ (directionsB(x,y)) |> Seq.distinct |> List.ofSeq
    let directionsK (x,y) = (directionsR(x,y)) @ (directionsB(x,y)) |> Seq.distinct |> List.ofSeq
    
   
    let analyse (x: int,y: int,t : string) = 
        let j = t.ToLower()
        match j with
        | InvariantEqual "b" -> Newtonsoft.Json.JsonConvert.SerializeObject([directionsB(x,y), t])
        | InvariantEqual "r" -> Newtonsoft.Json.JsonConvert.SerializeObject([directionsR(x,y), t])
        | InvariantEqual "n" -> Newtonsoft.Json.JsonConvert.SerializeObject([directionsN(x,y), t])
        | InvariantEqual "q" -> Newtonsoft.Json.JsonConvert.SerializeObject([directionsQ(x,y), t])
        | InvariantEqual "k" -> Newtonsoft.Json.JsonConvert.SerializeObject([directionsK(x,y), t])
        | InvariantEqual "p" -> Newtonsoft.Json.JsonConvert.SerializeObject([[(0,0)], t])
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
        {defaultConfig with bindings = [HttpBinding.createSimple HTTP "127.0.0.1" 8080]}
    
    choose
        [ GET >=> choose
            [ path "/call" >=> browse ]
        ]
    |> startWebServer app
 
    0 // return an integer exit code
