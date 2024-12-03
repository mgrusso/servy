#server() ->
#  {ok, listen_socket} = gen_tcp:listen(5678, [binary, {packet, 0},
#                                      {active, false}]),
#  {ok, Sock} = gen_tcp:accept(listen_socket),
#  {ok, Bin} = do_recv(Sock, []),
#  ok = gen_tcp:close(Sock),
#  ok = gen_tcp:close(listen_socket),
#  Bin.
defmodule Servy.HttpServer do
  @doc """
  Starts the server on the given `port` of localhost.
  """
  def start(port) when is_integer(port) and port > 1023 do
    {:ok, listen_socket} =
      :gen_tcp.listen(5678, [:binary, packet: :raw, active: false, reuseaddr: true])

    IO.puts "\n🎧 Listening for connection requests on port #{port}...\n"

    accept_loop(listen_socket)
  end

  @doc """
  Accepts client connections on the `listen_socket`
  """
  def accept_loop(listen_socket) do
    IO.puts "⏳ Waiting to accept a client connection...\n"
    {:ok, client_socket} = :gen_tcp.accept(listen_socket)

    IO.puts "⚡ Connection_accepted!\n"

    serve(client_socket)
    accept_loop(listen_socket)
  end

  @doc """
  Receives the request on the `client_socket` and
  sends a response back over the same socket.
  """
  def serve(client_socket) do
   client_socket
   |> read_request
   |> Servy.Handler.handle
   |> write_response(client_socket)
  end

  @doc """
  Receives a request on the `client_socket`
  """
  def read_request(client_socket) do
    {:ok, request} = :gen_tcp.recv(client_socket, 0) # all available bytes

    IO.puts "📩 Received request:\n"
    IO.puts request

    request
  end

  @doc """
  Returns a generic HTTP response.
  """
  def generate_response(_request) do
    """
    HTTP/1.1 200 OK\r
    Content-Type: text/plain\r
    Content-Length: 6\r
    \r
    Hello!
    """
  end

  @doc """
  Sends the `response` over the `client_socket`.
  """
  def write_response(response, client_socket) do
    :ok = :gen_tcp.send(client_socket, response)
    IO.puts "📯 Sent response\n"
    IO.puts response

    :gen_tcp.close(client_socket)
  end
end
