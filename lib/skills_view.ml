open Tyxml.Html
open Data_store
open Shared_view

let create_skill_card (skill : skill) =
  create_card [
    h3 [txt skill.category];
    ul ~a:[a_class ["skill-items"]] (
      List.map (fun item -> li [txt item]) skill.items
    )
  ]

let render_skills_page () =
  let skills = match get_skills () with Some s -> s | None -> [] in
  let page =
    html
      (head
        (title (txt "Skills"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Skills";
          div ~a:[a_class ["skills-list"]] (
            List.map create_skill_card skills
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page