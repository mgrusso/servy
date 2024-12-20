defmodule Servy.Fetcher do
@moduledoc """
Not needed anymore - Just demonstrated how the Task module works internally
"""
  def async(fun) do
    parent = self()

    spawn(fn -> send(parent, {self(), :result, fun.()}) end)
  end

  def get_result(pid) do
    receive do {^pid, :result, value} -> value end
  end
end
