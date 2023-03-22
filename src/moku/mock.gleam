import gleam/dynamic.{DecodeErrors, Dynamic}

pub type Content {
  Literal(String)
  Path(String)
}

pub type Mock {
  Mock(
    name: String,
    path: String,
    ingress_host: String,
    ingress_class: String,
    content_type: String,
    content: Content,
  )
}

pub fn decode(data: Dynamic) -> Result(Mock, DecodeErrors) {
  data
  |> dynamic.decode6(
    Mock,
    dynamic.field("name", dynamic.string),
    dynamic.field("path", dynamic.string),
    dynamic.field("ingress-host", dynamic.string),
    dynamic.field("ingress-class", dynamic.string),
    dynamic.field("content-type", dynamic.string),
    dynamic.any([
      dynamic.decode1(Literal, dynamic.field("response", dynamic.string)),
      dynamic.decode1(Path, dynamic.field("response-path", dynamic.string)),
    ]),
  )
}
