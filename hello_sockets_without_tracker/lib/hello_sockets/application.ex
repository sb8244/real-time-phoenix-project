#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule HelloSockets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias HelloSockets.Pipeline.{Consumer, Producer}
  # above consumer alias is not needed except for book examples
  alias HelloSockets.Pipeline.Producer
  alias HelloSockets.Pipeline.ConsumerSupervisor, as: Consumer

  def start(_type, _args) do
    :ok = HelloSockets.Statix.connect()

    children = [
      {Producer, name: Producer},
      {Consumer,
       subscribe_to: [{Producer, max_demand: 10, min_demand: 5}]},
      HelloSocketsWeb.Endpoint,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloSockets.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HelloSocketsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
