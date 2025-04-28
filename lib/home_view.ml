open Tyxml.Html
open Data_store
open Shared_view

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
            [ h3 [txt (strip_quotes bio.name)]
            ; p ~a:[a_class ["title"]] [txt (strip_quotes bio.title)]
            ; p ~a:[a_class ["contact"]] [txt (strip_quotes bio.email)]
            ; p ~a:[a_class ["location"]] [txt (strip_quotes bio.location)]
            ; p ~a:[a_class ["summary"]] [txt (strip_quotes bio.summary)]
            ; div ~a:[a_class ["social-items"]] [
                a ~a:[a_href bio.cv_url; a_class ["social-link"]] [
                  txt "Download CV"
                ]
              ]
            ; div ~a:[a_class ["social-links"]] [
                ul ~a:[a_class ["social-list"]] (
                  List.map (fun (platform, url) ->
                    li ~a:[a_class ["social-item"]] [
                      a ~a:[a_href (strip_quotes url); a_class ["social-link"]; a_target "_blank"] [
                        txt platform
                      ]
                    ]
                  ) bio.social
                )
              ]
            ]
        ]
  | None ->
      div []

let create_tab_links () =
  div ~a:[a_class ["tab-links"]] [
    a ~a:[a_href "/publications"; a_class ["tab-link"]] [txt (strip_quotes "Publications")];
    a ~a:[a_href "/conferences"; a_class ["tab-link"]] [txt (strip_quotes "Conferences")];
    a ~a:[a_href "/software"; a_class ["tab-link"]] [txt (strip_quotes "Software")];
  ]

let create_education_section education =
  match education with
  | [] -> div []
  | education ->
    div ~a:[a_class ["content-section"]] [
      create_section_header "Education";
      div ~a:[a_class ["content-list"]] (
        List.map (fun (edu : education) ->
          div ~a:[a_class ["content-item"]] [
            h3 [txt (strip_quotes edu.institution)];
            p ~a:[a_class ["degree"]] [txt (Printf.sprintf "%s in %s" (strip_quotes edu.degree) (strip_quotes edu.field))];
            p ~a:[a_class ["date"]] [
              txt (Printf.sprintf "%s - %s" (strip_quotes edu.start_date)
                (match edu.end_date with Some d -> d | None -> "Present"))
            ]
          ]
        ) education
      )
    ]

let create_work_experience_section work_experience =
  match work_experience with
  | [] -> div []
  | work_experience ->
    div ~a:[a_class ["content-section"]] [
      create_section_header "Work Experience";
      div ~a:[a_class ["content-list"]] (
        List.map (fun (exp : work_experience) ->
          div ~a:[a_class ["content-item"]] [
            h3 [txt (strip_quotes exp.company)];
            p ~a:[a_class ["position"]] [txt (strip_quotes exp.position)];
            p ~a:[a_class ["date"]] [
              txt (Printf.sprintf "%s - %s" (strip_quotes exp.start_date)
                (match exp.end_date with Some d -> d | None -> "Present"))
            ];
            ul ~a:[a_class ["description-list"]] (
              List.map (fun desc -> li [txt (strip_quotes desc)]) exp.description
            )
          ]
        ) work_experience
      )
    ]

let create_skills_section skills =
  match skills with
  | [] -> div []
  | skills ->
    div ~a:[a_class ["content-section"]] [
      create_section_header "Skills";
      div ~a:[a_class ["content-list"]] (
        List.map (fun (skill : skill) ->
          div ~a:[a_class ["content-item"]] [
            h3 [txt (strip_quotes skill.category)];
            ul ~a:[a_class ["skill-items"]] (
              List.map (fun item -> li [txt (strip_quotes item)]) skill.items
            )
          ]
        ) skills
      )
    ]

let create_collaborators_section collaborators =
  match collaborators with
  | [] -> div []
  | collaborators ->
    div ~a:[a_class ["content-section"]] [
      create_section_header "Collaborators";
      div ~a:[a_class ["content-list"]] (
        List.map (fun (collaborator : collaborator) ->
          div ~a:[a_class ["content-item"]] [
            h3 [txt (strip_quotes collaborator.name)];
            p ~a:[a_class ["institution"]] [txt (strip_quotes collaborator.institution)];
            p ~a:[a_class ["department"]] [txt (strip_quotes collaborator.department)];
            p ~a:[a_class ["collaboration-type"]] [txt (strip_quotes collaborator.collaboration_type)];
            p ~a:[a_class ["description"]] [txt (strip_quotes collaborator.description)]
          ]
        ) collaborators
      )
    ]

let create_publications_preview publications =
  match publications with
  | [] -> div []
  | publications ->
    let preview_items = take 3 publications in
    div ~a:[a_class ["preview-section"]] [
      create_section_header "Publications";
      div ~a:[a_class ["preview-list"]] (
        List.map (fun (pub : publication) ->
          div ~a:[a_class ["preview-item"]] [
            h3 [txt (strip_quotes pub.title)];
            p ~a:[a_class ["authors"]] [txt (String.concat ", " (List.map (fun a -> strip_quotes a) pub.authors))];
            p ~a:[a_class ["conference"]] [txt (strip_quotes pub.conference)];
            p ~a:[a_class ["year"]] [txt (string_of_int pub.year)]
          ]
        ) preview_items
      );
      if List.length publications > 3 then
        div ~a:[a_class ["view-more"]] [
          a ~a:[a_href "/publications"; a_class ["view-more-link"]] [
            txt (Printf.sprintf "View all %d Publications" (List.length publications))
          ]
        ]
      else div []
    ]

let create_conferences_preview conferences =
  match conferences with
  | [] -> div []
  | conferences ->
    let preview_items = take 3 conferences in
    div ~a:[a_class ["preview-section"]] [
      create_section_header "Conferences";
      div ~a:[a_class ["preview-list"]] (
        List.map (fun (conf : conference) ->
          div ~a:[a_class ["preview-item"]] [
            h3 [txt (strip_quotes conf.name)];
            p ~a:[a_class ["location"]] [txt (strip_quotes conf.location)];
            p ~a:[a_class ["date"]] [
              txt (Printf.sprintf "%s - %s" (strip_quotes conf.start_date) (strip_quotes conf.end_date))
            ]
          ]
        ) preview_items
      );
      if List.length conferences > 3 then
        div ~a:[a_class ["view-more"]] [
          a ~a:[a_href "/conferences"; a_class ["view-more-link"]] [
            txt (Printf.sprintf "View all %d Conferences" (List.length conferences))
          ]
        ]
      else div []
    ]

let create_software_preview softwares =
  match softwares with
  | [] -> div []
  | softwares ->
    let preview_items = take 3 softwares in
    div ~a:[a_class ["preview-section"]] [
      create_section_header "Software";
      div ~a:[a_class ["preview-list"]] (
        List.map (fun (software : software) ->
          div ~a:[a_class ["preview-item"]] [
            h3 [txt (strip_quotes software.name)];
            p ~a:[a_class ["description"]] [txt (strip_quotes software.description)];
            p ~a:[a_class ["technologies"]] [
              txt (String.concat ", " (List.map (fun t -> strip_quotes t) software.technologies))
            ]
          ]
        ) preview_items
      );
      if List.length softwares > 3 then
        div ~a:[a_class ["view-more"]] [
          a ~a:[a_href "/software"; a_class ["view-more-link"]] [
            txt (Printf.sprintf "View all %d Software Projects" (List.length softwares))
          ]
        ]
      else div []
    ]

let render_home_page () =
  let bio = get_bio () in
  let education = match get_education () with Some e -> e | None -> [] in
  let work_experience = match get_work_experience () with Some w -> w | None -> [] in
  let skills = match get_skills () with Some s -> s | None -> [] in
  let (_papers, _) = match get_publications () with Some (p, t) -> (p, t) | None -> ([], []) in
  let _conferences = match get_conferences () with Some c -> c | None -> [] in
  let _softwares = match get_software () with Some s -> s | None -> [] in
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
          create_tab_links ();
          create_education_section education;
          create_work_experience_section work_experience;
          create_skills_section skills;
          create_collaborators_section collaborators;
        ]
      ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) page
