(lang dune 3.8)

(name mysite_OCaml)

(version 0.1.0)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name <author@example.com>")

(maintainers "Maintainer Name <maintainer@example.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name mysite_OCaml)
 (synopsis "Personal website built with OCaml")
 (description "A personal website showcasing CV and work history")
 (depends
  (ocaml (>= 4.14.0))
  dream
  dream-httpaf
  dream-h2
  dream-pure
  tyxml
  ppx_tyxml
  caqti
  caqti-driver-postgresql
  logs
  lwt
  lwt_ppx
  ptime
  yojson
  (alcotest :with-test)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
