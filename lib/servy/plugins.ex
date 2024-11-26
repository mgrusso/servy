defmodule Servy.Plugins do
  @moduledoc "Helper module for the webserver"
  alias Servy.Conv
  require Logger

  @doc "Logs 404 requests"
  def track(%Conv{status: 404, path: path} = conv) do
    Logger.error "NOT FOUND for url #{path}"
    conv
  end

  def track(%Conv{} = conv) , do: conv

  def rewrite_path(%Conv{path: path} = conv) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path_captures(conv, %{"thing" => thing, "id" => id}) do
    %{ conv | path: "/#{thing}/#{id}" }
  end

  def rewrite_path_captures(conv, nil) , do: conv

  def log(%Conv{} = conv), do: IO.inspect conv
end
