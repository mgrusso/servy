defmodule Servy.PledgeServer do
  def create_pledge(name, amount) do
    {:ok, id} = send_pledge_to_service(name, amount)

    # Cache the pledge
    [ {"larry", 10} ]
  end

  def recent_pledges do
    # Return most recent pledges (cache):
    [ {"larry", 10} ]
  end

  defp send_pledge_to_service(_name, _amount)  do
    # Simulate sending pledge to service and get a pledge-ID
    {:ok, "pledge-#{:rand.uniform(1000)}"}
  end
end
