import gleam/http
import gleam/http/request.{Request}

pub fn new_request(token: String) -> Request(_) {
  request.new()
  |> request.set_scheme(http.Https)
  |> request.set_host("kubernetes.default.svc.cluster.local")
  |> request.prepend_header("authorization", "bearer " <> token)
}

pub fn list_ingresses(request: Request(_), namespace: String) -> Request(_) {
  request
  |> request.set_method(http.Get)
  |> request.set_path(
    "/apis/networking.k8s.io/v1/namespaces/" <> namespace <> "/ingresses",
  )
}

pub fn create_ingress(
  request: Request(_),
  namespace: String,
  body: String,
) -> Request(_) {
  request
  |> request.set_method(http.Post)
  |> request.set_body(body)
  |> request.prepend_header("content-type", "application/json")
  |> request.set_path(
    "/apis/networking.k8s.io/v1/namespaces/" <> namespace <> "/ingresses/",
  )
}

pub fn delete_ingress(
  request: Request(_),
  name: String,
  namespace: String,
) -> Request(_) {
  request
  |> request.set_method(http.Delete)
  |> request.set_path(
    "/apis/networking.k8s.io/v1/namespaces/" <> namespace <> "/ingresses/" <> name,
  )
}
