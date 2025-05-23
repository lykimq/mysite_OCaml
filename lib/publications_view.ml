open Tyxml.Html
open Data_store
open Shared_view

let create_publication_card (publication : publication) =
  create_card [
    h3 [txt (strip_quotes publication.title)];
    create_author_list publication.authors;
    p ~a:[a_class ["conference"]] [txt (strip_quotes publication.conference)];
    p ~a:[a_class ["year"]] [txt (strip_quotes (string_of_int publication.year))];
    (match publication.paper_url with
    | Some url -> a ~a:[a_href url; a_class ["paper-link"]; a_target "_blank"] [txt "View Paper"]
    | None -> div []);
    (match publication.talk_url with
    | Some url -> a ~a:[a_href url; a_class ["talk-link"]; a_target "_blank"] [txt "View Talk"]
    | None -> div [])
  ]

let render_publications_page () =
  let (papers, talks) = match get_publications () with Some (p, t) -> (p, t) | None -> ([], []) in
  let page =
    html
      (head
        (title (txt "Publications"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/detail.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["detail-page"]] [
        div ~a:[a_class ["container"]] [
          create_page_header "Publications";
          div ~a:[a_class ["publications-list"]] (
            List.map create_publication_card papers
          );
          if List.length talks > 0 then
            div ~a:[a_class ["talks-section"]] [
              h2 [txt "Talks"];
              div ~a:[a_class ["talks-list"]] (
                List.map create_publication_card talks
              )
            ]
          else div []
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ~indent:false ()) page