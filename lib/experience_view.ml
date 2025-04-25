open Tyxml.Html
open Data_store
open Shared_view

let create_experience_card (experience : work_experience) =
  create_card [
    h3 [txt experience.company];
    p ~a:[a_class ["position"]] [txt experience.position];
    create_date_range experience.start_date experience.end_date;
    create_description_list experience.description
  ]

let render_experience_page () =
  let experience = match get_work_experience () with Some e -> e | None -> [] in
  let page =
    html
      (head
        (title (txt "Experience"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Experience";
          div ~a:[a_class ["experience-list"]] (
            List.map create_experience_card experience
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page