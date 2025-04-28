open Yojson.Basic.Util
open Yojson.Basic

type work_experience = {
  company: string;
  position: string;
  start_date: string;
  end_date: string option;
  description: string list;
}

type education = {
  institution: string;
  degree: string;
  field: string;
  start_date: string;
  end_date: string option;
}

type skill = {
  category: string;
  items: string list;
}

type bio = {
  name: string;
  title: string;
  email: string;
  phone: string;
  location: string;
  summary: string;
  cv_url: string;
  social: (string * string) list;
}

type publication = {
  id: string;
  title: string;
  authors: string list;
  conference: string;
  year: int;
  paper_url: string option;
  talk_url: string option;
}

type conference = {
  name: string;
  location: string;
  start_date: string;
  end_date: string;
  website_url: string option;
  description: string;
}

type software = {
  name: string;
  description: string;
  github_url: string option;
  documentation_url: string option;
  technologies: string list;
}

type collaborator = {
  name: string;
  institution: string;
  department: string;
  email: string;
  website_url: string option;
  collaboration_type: string;
  description: string;
}

let read_json_file filename =
  try
    let content = Yojson.Basic.from_file filename in
    Some content
  with _ -> None

let get_bio () =
  match read_json_file "data/bio.json" with
  | Some json ->
    let name = json |> member "name" |> to_string in
    let title = json |> member "title" |> to_string in
    let email = json |> member "email" |> to_string in
    let phone = json |> member "phone" |> to_string in
    let location = json |> member "location" |> to_string in
    let summary = json |> member "summary" |> to_string in
    let cv_url = json |> member "cv_url" |> to_string in
    let social = json |> member "social" |> to_assoc |> List.map (fun (k, v) ->
      (k, to_string v)
    ) in
    Some { name; title; email; phone; location; summary; cv_url; social }
  | None -> None

let get_work_experience () =
  match read_json_file "data/work_experience.json" with
  | Some json ->
    let experiences = json |> member "experience" |> to_list |> List.map (fun w ->
      {
        company = w |> member "company" |> to_string;
        position = w |> member "position" |> to_string;
        start_date = w |> member "start_date" |> to_string;
        end_date = w |> member "end_date" |> to_string_option;
        description = w |> member "description" |> to_list |> List.map to_string;
      }
    ) in
    Some experiences
  | _ -> None

let get_education () =
  match read_json_file "data/education.json" with
  | Some json ->
    let education = json |> member "education" |> to_list |> List.map (fun e ->
      {
        institution = e |> member "institution" |> to_string;
        degree = e |> member "degree" |> to_string;
        field = e |> member "field" |> to_string;
        start_date = e |> member "start_date" |> to_string;
        end_date = e |> member "end_date" |> to_string_option;
      }
    ) in
    Some education
  | _ -> None

let get_skills () =
  match read_json_file "data/skills.json" with
  | Some json ->
    let skills = json |> member "skills" |> to_list |> List.map (fun s ->
      {
        category = s |> member "category" |> to_string;
        items = s |> member "items" |> to_list |> List.map to_string;
      }
    ) in
    Some skills
  | _ -> None

let get_publications () =
  match read_json_file "data/publications.json" with
  | Some json ->
    let papers = json |> member "papers" |> to_list |> List.map (fun p ->
      {
        id = p |> member "id" |> to_string;
        title = p |> member "title" |> to_string;
        authors = p |> member "authors" |> to_list |> List.map to_string;
        conference = p |> member "conference" |> to_string;
        year = p |> member "year" |> to_int;
        paper_url = p |> member "paper_url" |> to_string_option;
        talk_url = p |> member "talk_url" |> to_string_option;
      }
    ) in
    let talks = json |> member "talks" |> to_list |> List.map (fun t ->
      {
        id = t |> member "id" |> to_string;
        title = t |> member "title" |> to_string;
        authors = t |> member "authors" |> to_list |> List.map to_string;
        conference = t |> member "conference" |> to_string;
        year = t |> member "year" |> to_int;
        paper_url = t |> member "paper_url" |> to_string_option;
        talk_url = t |> member "talk_url" |> to_string_option;
      }
    ) in
    Some (papers, talks)
  | None -> None

let get_conferences () =
  match read_json_file "data/conferences.json" with
  | Some json ->
    let conferences = json |> member "conferences" |> to_list |> List.map (fun conf ->
      {
        name = conf |> member "name" |> to_string;
        location = conf |> member "location" |> to_string;
        start_date = conf |> member "start_date" |> to_string;
        end_date = conf |> member "end_date" |> to_string;
        website_url = conf |> member "website_url" |> to_string_option;
        description = conf |> member "description" |> to_string;
      }
    ) in
    Some conferences
  | None -> None

let get_software () =
  match read_json_file "data/software.json" with
  | Some json ->
    let projects = json |> member "projects" |> to_list |> List.map (fun p ->
      {
        name = p |> member "name" |> to_string;
        description = p |> member "description" |> to_string;
        github_url = p |> member "github_url" |> to_string_option;
        documentation_url = p |> member "documentation_url" |> to_string_option;
        technologies = p |> member "technologies" |> to_list |> List.map to_string;
      }
    ) in
    Some projects
  | _ -> None

let get_collaborators () =
  match read_json_file "data/collaborators.json" with
  | Some json ->
    let collaborators = json |> member "collaborators" |> to_list |> List.map (fun c ->
      {
        name = c |> member "name" |> to_string;
        institution = c |> member "institution" |> to_string;
        department = c |> member "department" |> to_string;
        email = c |> member "email" |> to_string;
        website_url = c |> member "website_url" |> to_string_option;
        collaboration_type = c |> member "collaboration_type" |> to_string;
        description = c |> member "description" |> to_string;
      }
    ) in
    Some collaborators
  | _ -> None
