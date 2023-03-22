import gleam/option.{Option}
import kube/meta.{ObjectMeta}

pub type Ingress {
  Ingress(ObjectMeta, Spec)
}

pub type Spec {
  Spec(class_name: Option(String), rules: List(Rule))
}

pub type Rule {
  Rule(host: Option(String), http: HttpRule)
}

pub type HttpRule {
  HttpRule(paths: List(Path))
}

pub type PathType {
  Prefix
  Exact
  ImplementationSpecific
}

pub type Port {
  PortNumber(Int)
  PortName(String)
}

pub type Backend {
  ServiceBackend(name: String, port: Port)
  ResourceBackend(api_group: String, kind: String, name: String)
}

pub type Path {
  Path(path: String, path_type: PathType, backend: Backend)
}
