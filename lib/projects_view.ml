open Tyxml.Html
open Data_store
open Shared_view

let create_project_card (project : project) =
  create_card [
    h3 [txt project.name];
    p ~a:[a_class ["description"]] [txt project.description];
    create_date_range project.start_date project.end_date;
    match project.technologies with
    | Some techs -> div ~a:[a_class ["tech-tags"]] (List.map create_tech_tag techs)
    | None -> div [];
    match project.github_url with
    | Some url -> a ~a:[a_href url; a_class ["github-link"]] [txt "View on GitHub"]
    | None -> div []
  ]

let render_projects_page () =
  let projects = match get_projects () with Some p -> p | None -> [] in
  let page =
    html
      (head
        (title (txt "Projects"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Projects";
          div ~a:[a_class ["project-list"]] (
            List.map create_project_card projects
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page