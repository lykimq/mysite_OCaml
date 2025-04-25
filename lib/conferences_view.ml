open Tyxml.Html
open Data_store
open Shared_view

let create_conference_card (conference : conference) =
  create_card [
    h3 [txt conference.name];
    p ~a:[a_class ["location"]] [txt conference.location];
    create_date_range conference.start_date (Some conference.end_date);
    (match conference.website_url with
    | Some url -> a ~a:[a_href url; a_class ["website-link"]] [txt "View Website"]
    | None -> div []);
    p ~a:[a_class ["description"]] [txt conference.description]
  ]

let render_conferences_page () =
  let conferences = match get_conferences () with Some c -> c | None -> [] in
  let page =
    html
      (head
        (title (txt "Conferences"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Conferences";
          div ~a:[a_class ["conferences-list"]] (
            List.map create_conference_card conferences
          )
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page