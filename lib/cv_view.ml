open Tyxml.Html
open Cv

let render_work_experience (work: work_experience) =
  let end_date = match work.end_date with
    | Some date -> txt date
    | None -> txt "Present"
  in
  div ~a:[a_class ["work-experience"]] [
    h3 [txt work.company];
    h4 [txt work.position];
    p ~a:[a_class ["date"]] [
      txt (work.start_date ^ " - ");
      end_date
    ];
    ul (List.map (fun desc -> li [txt desc]) work.description)
  ]

let render_education (edu: education) =
  let end_date = match edu.end_date with
    | Some date -> txt date
    | None -> txt "Present"
  in
  div ~a:[a_class ["education"]] [
    h3 [txt edu.institution];
    h4 [txt (edu.degree ^ " in " ^ edu.field)];
    p ~a:[a_class ["date"]] [
      txt (edu.start_date ^ " - ");
      end_date
    ]
  ]

let render_skill (skill: skill) =
  div ~a:[a_class ["skill-category"]] [
    h3 [txt skill.category];
    ul (List.map (fun item -> li [txt item]) skill.items)
  ]

let render_cv (cv: cv) =
  let html_doc = html
    (head
      (title (txt (cv.name ^ " - CV")))
      [
        meta ~a:[a_charset "UTF-8"] ();
        link ~rel:[`Stylesheet] ~href:"/static/css/style.css" ()
      ])
    (body ~a:[a_class ["cv"]] [
      header [
        h1 [txt cv.name];
        h2 [txt cv.title];
        p [txt cv.location];
        p [txt cv.email];
        (match cv.phone with
         | Some phone -> p [txt phone]
         | None -> p []);
      ];
      section ~a:[a_class ["summary"]] [
        h2 [txt "Summary"];
        p [txt cv.summary];
      ];
      section ~a:[a_class ["work-experience"]] [
        h2 [txt "Work Experience"];
        div (List.map render_work_experience cv.work_experience);
      ];
      section ~a:[a_class ["education"]] [
        h2 [txt "Education"];
        div (List.map render_education cv.education);
      ];
      section ~a:[a_class ["skills"]] [
        h2 [txt "Skills"];
        div (List.map render_skill cv.skills);
      ];
    ])
  in
  Format.asprintf "%a" (Tyxml.Html.pp ()) html_doc
