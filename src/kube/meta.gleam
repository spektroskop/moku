import gleam/option.{Option}

pub type TypeMeta {
  TypeMeta(api_version: String, kind: String)
}

pub type ObjectMeta {
  ObjectMeta(
    name: String,
    namespace: Option(String),
    labels: List(#(String, String)),
  )
}
