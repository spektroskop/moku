import gleam/bit_builder.{BitBuilder}
import gleam/dynamic.{Dynamic}
import gleam/erlang/atom.{Atom}
import gleam/erlang/charlist.{Charlist}
import gleam/http/request.{Request}
import gleam/iterator
import gleam/list
import gleam/map.{Map}

external fn hackney_merge_ssl_options(Charlist, List(Dynamic)) -> Dynamic =
  "glue" "hackney_merge_ssl_options"

pub type Option {
  CACertFile(String)
}

pub type Client {
  Client(options: Map(Atom, List(Option)))
}

pub fn new(options: List(Option)) {
  Client(
    options: iterator.from_list(options)
    |> iterator.group(by: fn(option) {
      case option {
        CACertFile(_) -> {
          let assert Ok(group) = atom.from_string("ssl_options")
          group
        }
      }
    }),
  )
}

fn encode_options(
  request: Request(BitBuilder),
  options: Map(Atom, List(Option)),
) -> Dynamic {
  options
  |> map.map_values(option_group_encoder(request.host))
  |> map.to_list()
  |> dynamic.from()
}

fn option_group_encoder(host: String) {
  fn(group: Atom, options: List(Option)) {
    let options =
      hackney_merge_ssl_options(
        charlist.from_string(host),
        list.map(options, encode_option),
      )

    #(group, options)
  }
}

fn encode_option(option: Option) -> Dynamic {
  case option {
    CACertFile(path) -> {
      let assert Ok(name) = atom.from_string("cacertfile")

      dynamic.from(#(name, charlist.from_string(path)))
    }
  }
}
