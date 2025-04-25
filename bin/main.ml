open Home_view
open Education_view
open Experience_view
open Skills_view
open Publications_view
open Conferences_view
open Software_view
open Collaborators_view

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
      Dream.get "/" (fun _ -> Dream.html (render_home_page ()));
      Dream.get "/education" (fun _ -> Dream.html (render_education_page ()));
      Dream.get "/experience" (fun _ -> Dream.html (render_experience_page ()));
      Dream.get "/skills" (fun _ -> Dream.html (render_skills_page ()));
      Dream.get "/publications" (fun _ -> Dream.html (render_publications_page ()));
      Dream.get "/conferences" (fun _ -> Dream.html (render_conferences_page ()));
      Dream.get "/software" (fun _ -> Dream.html (render_software_page ()));
      Dream.get "/collaborators" (fun _ -> Dream.html (render_collaborators_page ()));
      Dream.get "/static/**" (Dream.static "static");
      Dream.any "/**" (fun _ -> Dream.empty `Not_Found)
    ]