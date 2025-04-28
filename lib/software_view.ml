open Tyxml.Html
open Data_store
open Shared_view

let create_software_card (software : software) =
  create_card [
    h3 [txt (strip_quotes software.name)];
    p ~a:[a_class ["description"]] [txt (strip_quotes software.description)];
    (match software.github_url with
    | Some url -> a ~a:[a_href url; a_class ["github-link"]] [txt "View on GitHub"]
    | None -> div []);
    (match software.documentation_url with
    | Some url -> a ~a:[a_href url; a_class ["docs-link"]] [txt "View Documentation"]
    | None -> div []);
    create_tech_tags software.technologies
  ]

let render_software_page () =
  let software = match get_software () with Some s -> s | None -> [] in
  let page =
    html
      (head
        (title (txt "Software"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Software";
          div ~a:[a_class ["software-list"]] (
            List.map create_software_card software
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page