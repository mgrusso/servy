defmodule Servy.Parser do

  alias Servy.Conv #as: Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n", parts: 2)

    [request_line | header_lines ] = String.split(top, "\n")

    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_string)

    IO.inspect header_lines

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
      }
  end

  def parse_headers(header_lines) do
    header_lines
    |> Enum.reduce(%{}, fn line, acc ->
      [key, value] = String.split(line, ": ")
      Map.put(acc, key, value)
    end)
  end

  def parse_params("application/x-www-form-urlencoded", params_string) do
    IO.puts "+++++++++++ parse_params matched ++++++++++++++"
    params_string |> String.trim |> URI.decode_query
  end

  def parse_params(_, _), do: %{}

end
