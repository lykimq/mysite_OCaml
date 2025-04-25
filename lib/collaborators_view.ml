open Tyxml.Html
open Data_store
open Shared_view

let create_collaborator_card (collaborator : collaborator) =
  create_card [
    h3 [txt collaborator.name];
    p ~a:[a_class ["institution"]] [txt collaborator.institution];
    p ~a:[a_class ["department"]] [txt collaborator.department];
    p ~a:[a_class ["email"]] [txt collaborator.email];
    (match collaborator.website_url with
    | Some url -> a ~a:[a_href url; a_class ["website-link"]] [txt "View Website"]
    | None -> div []);
    p ~a:[a_class ["collaboration-type"]] [txt collaborator.collaboration_type];
    p ~a:[a_class ["description"]] [txt collaborator.description]
  ]

let render_collaborators_page () =
  let collaborators = match get_collaborators () with Some c -> c | None -> [] in
  let page =
    html
      (head
        (title (txt "Collaborators"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Collaborators";
          div ~a:[a_class ["collaborators-list"]] (
            List.map create_collaborator_card collaborators
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ~indent:false ()) page