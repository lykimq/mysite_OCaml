open Tyxml.Html
open Data_store
open Shared_view

let create_collaborator_card collaborator =
  let name = collaborator.name in
  let institution = collaborator.institution in
  let department = collaborator.department in
  let email = collaborator.email in
  let website_url = match collaborator.website_url with
    | Some url -> Some url
    | None -> None
  in
  let collaboration_type = collaborator.collaboration_type in
  let description = collaborator.description in

  create_card [
    div ~a:[a_class ["collaborator-info"]] [
      h3 ~a:[a_class ["collaborator-name"]] [txt name];
      div ~a:[a_class ["collaborator-details"]] [
        p [txt institution];
        p [txt department];
        p [txt email];
        p [txt collaboration_type];
        p [txt description];
        (match website_url with
        | Some url -> p ~a:[a_class ["website-link"]] [a ~a:[a_href url] [txt "Website"]]
        | None -> p [txt ""])
      ]
    ]
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