defmodule MyProject.MixProject do
  use Mix.Project

  def project() do
    [
      app: :truncatable_primes,
      version: "0.0.1",
      elixir: "~> 1.17.2",
      deps: deps()
    ]
  end

  def application() do
    []
  end

  defp deps() do
    [{:elixir_math, "~> 0.1.2"}]
  end
end
