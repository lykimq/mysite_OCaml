open Tyxml.Html

let create_page_header title =
  div ~a:[a_class ["page-header"]] [
    h1 [txt title];
    a ~a:[a_href "/"; a_class ["back-link"]] [txt "← Back to Home"]
  ]

let create_section title content =
  div ~a:[a_class ["detail-section"]] [
    h2 ~a:[a_class ["section-title"]] [txt title];
    content
  ]

let create_card content =
  div ~a:[a_class ["card"]] content

let create_link_button ?(class_="") href text =
  a ~a:[a_href href; a_class ["link-button"; class_]] [txt text]

let create_download_button href text =
  a ~a:[a_href href; a_class ["download-button"]] [txt text]

let create_tech_tag text =
  span ~a:[a_class ["tech-tag"]] [txt text]

let create_tech_tags tags =
  div ~a:[a_class ["tech-tags"]] (List.map create_tech_tag tags)

let create_date_range start_date end_date =
  p ~a:[a_class ["date-range"]] [
    txt (Printf.sprintf "%s - %s" start_date
      (match end_date with Some d -> d | None -> "Present"))
  ]

let create_description_list items =
  ul ~a:[a_class ["description-list"]] (
    List.map (fun item -> li [txt item]) items
  )

let create_author_list authors =
  p ~a:[a_class ["author-list"]] [
    txt (String.concat ", " authors)
  ]

let create_metadata items =
  div ~a:[a_class ["metadata"]] (
    List.map (fun (label, value) ->
      div ~a:[a_class ["metadata-item"]] [
        span ~a:[a_class ["metadata-label"]] [txt label];
        span ~a:[a_class ["metadata-value"]] [txt value]
      ]
    ) items
  )