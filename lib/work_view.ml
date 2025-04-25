open Tyxml.Html
open Data_store
open Shared_view

let create_work_card (work : work_experience) =
  create_card [
    h3 [txt work.company];
    p ~a:[a_class ["position"]] [txt work.position];
    create_date_range work.start_date work.end_date;
    p ~a:[a_class ["location"]] [txt work.location];
    match work.description with
    | Some desc -> create_description_list desc
    | None -> div [];
    match work.technologies with
    | Some techs -> div ~a:[a_class ["tech-tags"]] (List.map create_tech_tag techs)
    | None -> div []
  ]

let render_work_page () =
  let work = match get_work_experience () with Some w -> w | None -> [] in
  let page =
    html
      (head
        (title (txt "Work Experience"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Work Experience";
          div ~a:[a_class ["work-list"]] (
            List.map create_work_card work
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page