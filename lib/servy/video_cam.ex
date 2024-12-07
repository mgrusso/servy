defmodule Servy.VideoCam do
  @doc """
  Simulates sending a request to an external API
  to get a snapshot image from a video camera.
  """
  def get_snapshot(camera_name) do
    # CODE TO SEND EXTERNAL API REQUEST WOULD GO HERE

    # Sleep for 1 sec to simulate that the API could be slow
    :timer.sleep(1000)

    # Example response returned from the API
    "#{camera_name}-snapshot.jpg"
  end
end
