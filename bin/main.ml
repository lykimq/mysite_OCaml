open Cv_view

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/" (fun _ -> Dream.html (render_cv Cv_data.sample_cv));
    Dream.get "/static/**" (Dream.static "static");
    Dream.any "/**" (fun _ -> Dream.empty `Not_Found)
  ]