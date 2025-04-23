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

type cv = {
  name: string;
  title: string;
  email: string;
  phone: string option;
  location: string;
  summary: string;
  work_experience: work_experience list;
  education: education list;
  skills: skill list;
}

let empty_cv = {
  name = "";
  title = "";
  email = "";
  phone = None;
  location = "";
  summary = "";
  work_experience = [];
  education = [];
  skills = [];
}


