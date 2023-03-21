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
