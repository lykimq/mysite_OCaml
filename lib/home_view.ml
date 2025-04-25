open Tyxml.Html
open Data_store

let take n lst =
  let rec aux acc n = function
    | [] -> List.rev acc
    | hd::tl when n > 0 -> aux (hd::acc) (n-1) tl
    | _ -> List.rev acc
  in
  aux [] n lst

let create_section_header title =
  div ~a:[a_class ["section-header"]] [h2 [txt title]]

let create_bio_section (bio : bio option) =
  match bio with
  | Some bio ->
      div
        ~a:[a_class ["bio-section"]]
        [ create_section_header "About Me"
        ; div
            ~a:[a_class ["bio-content"]]
            [ h3 [txt bio.name]
            ; p ~a:[a_class ["title"]] [txt bio.title]
            ; p ~a:[a_class ["contact"]] [txt bio.email]
            ; p ~a:[a_class ["location"]] [txt bio.location]
            ; p ~a:[a_class ["summary"]] [txt bio.summary] ]
        ]
  | None ->
      div []

let create_nav_links () =
  div ~a:[a_class ["nav-links"]] [
    a ~a:[a_href "/education"; a_class ["nav-link"]] [txt "Education"];
    a ~a:[a_href "/experience"; a_class ["nav-link"]] [txt "Work Experience"];
    a ~a:[a_href "/skills"; a_class ["nav-link"]] [txt "Skills"];
    a ~a:[a_href "/publications"; a_class ["nav-link"]] [txt "Publications"];
    a ~a:[a_href "/conferences"; a_class ["nav-link"]] [txt "Conferences"];
    a ~a:[a_href "/software"; a_class ["nav-link"]] [txt "Software"];
    a ~a:[a_href "/collaborators"; a_class ["nav-link"]] [txt "Collaborators"];
  ]

let create_preview_section title items item_to_html =
  match items with
  | [] -> div []
  | items ->
    let preview_items = take 3 items in
    div ~a:[a_class ["preview-section"]] [
      create_section_header title;
      div ~a:[a_class ["preview-list"]] (
        List.map item_to_html preview_items
      );
      if List.length items > 3 then
        div ~a:[a_class ["view-more"]] [
          a ~a:[a_href ("/" ^ String.lowercase_ascii title); a_class ["view-more-link"]] [
            txt (Printf.sprintf "View all %d %s" (List.length items) title)
          ]
        ]
      else div []
    ]

let create_education_preview education =
  create_preview_section "Education" education (fun (edu : education) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt edu.institution];
      p ~a:[a_class ["degree"]] [txt (Printf.sprintf "%s in %s" edu.degree edu.field)];
      p ~a:[a_class ["date"]] [
        txt (Printf.sprintf "%s - %s" edu.start_date
          (match edu.end_date with Some d -> d | None -> "Present"))
      ]
    ]
  )

let create_work_experience_preview work_experience =
  create_preview_section "Work Experience" work_experience (fun (exp : work_experience) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt exp.company];
      p ~a:[a_class ["position"]] [txt exp.position];
      p ~a:[a_class ["date"]] [
        txt (Printf.sprintf "%s - %s" exp.start_date
          (match exp.end_date with Some d -> d | None -> "Present"))
      ]
    ]
  )

let create_skills_preview skills =
  create_preview_section "Skills" skills (fun (skill : skill) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt skill.category];
      ul ~a:[a_class ["skill-items"]] (
        List.map (fun item -> li [txt item]) skill.items
      )
    ]
  )

let create_publications_preview publications =
  create_preview_section "Publications" publications (fun (pub : publication) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt pub.title];
      p ~a:[a_class ["authors"]] [txt (String.concat ", " pub.authors)];
      p ~a:[a_class ["conference"]] [txt pub.conference];
      p ~a:[a_class ["year"]] [txt (string_of_int pub.year)]
    ]
  )

let create_conferences_preview conferences =
  create_preview_section "Conferences" conferences (fun (conf : conference) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt conf.name];
      p ~a:[a_class ["location"]] [txt conf.location];
      p ~a:[a_class ["date"]] [
        txt (Printf.sprintf "%s - %s" conf.start_date conf.end_date)
      ]
    ]
  )

let create_software_preview softwares =
  create_preview_section "Software" softwares (fun (software : software) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt software.name];
      p ~a:[a_class ["description"]] [txt software.description];
      p ~a:[a_class ["technologies"]] [
        txt (String.concat ", " software.technologies)
      ]
    ]
  )

let create_collaborators_preview collaborators =
  create_preview_section "Collaborators" collaborators (fun (collaborator : collaborator) ->
    div ~a:[a_class ["preview-item"]] [
      h3 [txt collaborator.name];
      p ~a:[a_class ["institution"]] [txt collaborator.institution];
      p ~a:[a_class ["department"]] [txt collaborator.department]
    ]
  )

let render_home_page () =
  let bio = get_bio () in
  let education = match get_education () with Some e -> e | None -> [] in
  let work_experience = match get_work_experience () with Some w -> w | None -> [] in
  let skills = match get_skills () with Some s -> s | None -> [] in
  let (papers, _) = match get_publications () with Some (p, _) -> (p, []) | None -> ([], []) in
  let conferences = match get_conferences () with Some c -> c | None -> [] in
  let softwares = match get_software () with Some s -> s | None -> [] in
  let collaborators = match get_collaborators () with Some c -> c | None -> [] in

  let page =
    html
      (head
        (title (txt "Home"))
        [
          meta ~a:[a_charset "UTF-8"] ();
          link ~rel:[`Stylesheet] ~href:"/static/css/home.css" ();
          link ~rel:[`Stylesheet] ~href:"https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" ();
        ])
      (body ~a:[a_class ["home-page"]] [
        div ~a:[a_class ["container"]] [
          create_bio_section bio;
          create_nav_links ();
          create_education_preview education;
          create_work_experience_preview work_experience;
          create_skills_preview skills;
          create_publications_preview papers;
          create_conferences_preview conferences;
          create_software_preview softwares;
          create_collaborators_preview collaborators;
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page
