defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear
  alias Servy.BearView

  #@template_path Path.expand("../../templates", __DIR__)

  #defp render(conv, template, bindings \\ []) do
  #  content =
  #  @template_path
  #  |> Path.join(template)
  #  |> EEx.eval_file(bindings)
  #  %{ conv | status: 200, resp_body: content }
  #end

  def index(conv) do
    bears =
    Wildthings.list_bears()
    |> Enum.sort(&Bear.order_asc_by_name/2)

    #render(conv, "index.eex", bears: bears)
    %{ conv | status: 200, resp_body: BearView.index(bears) }
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    #render(conv, "show.eex", bear: bear)
    %{ conv | status: 200, resp_body: BearView.show(bear) }
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{ conv | status: 201,
        resp_body: "Created a #{type} bear named #{name}!" }
  end

#  def delete(%Conv{path: path} = conv) do
  def delete(%{path: path} = conv) do
    %{conv | status: 403, resp_body: "You are not allowed to delete #{path}"}
  end

end
