# Personal Website in OCaml

A modern personal website built with OCaml, showcasing CV and work history.

## Features

- Responsive design
- CV display
- Work history timeline
- Blog section (optional)
- Contact form
- Dark/Light mode

## Tech Stack

- **Backend**: Dream (OCaml web framework)
- **Frontend**: TyXML + Tailwind CSS + Alpine.js
- **Database**: PostgreSQL
- **Build System**: Dune

## Setup

1. Install dependencies:
```bash
opam install . --deps-only
```

2. Set up PostgreSQL database:
```bash
createdb mysite_ocaml
```

3. Run the application:
```bash
dune exec mysite_OCaml
```

## Development

- Run tests: `dune test`
- Build: `dune build`
- Watch mode: `dune build -w`

## Project Structure

```
mysite_OCaml/
├── bin/              # Executable entry points
├── lib/              # Library code
│   ├── models/      # Database models
│   ├── views/       # HTML templates
│   ├── controllers/ # Request handlers
│   └── utils/       # Utility functions
├── static/          # Static assets
│   ├── css/
│   ├── js/
│   └── images/
└── test/            # Test suite
```

## License

MIT