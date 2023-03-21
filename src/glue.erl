-module(glue).

-export([
  hackney_merge_ssl_options/2
]).

hackney_merge_ssl_options(Host, Options) ->
    hackney_connection:merge_ssl_opts(Host, Options).
