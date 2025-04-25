open Tyxml.Html
open Data_store
open Shared_view

let create_education_card (education : education) =
  create_card [
    h3 [txt education.institution];
    p ~a:[a_class ["degree"]] [txt education.degree];
    p ~a:[a_class ["field"]] [txt education.field];
    create_date_range education.start_date education.end_date
  ]

let render_education_page () =
  let education = match get_education () with Some e -> e | None -> [] in
  let page =
    html
      (head
        (title (txt "Education"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Education";
          div ~a:[a_class ["education-list"]] (
            List.map create_education_card education
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page