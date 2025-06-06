defmodule UncookedGps.MixProject do
  use Mix.Project

  def project do
    [
      app: :uncooked_gps,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {UncookedGps.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:req, "~> 0.5.10"},
      {:tz, "~> 0.28.1"},
      {:mock, "~> 0.3.0", only: :test},
      {:ex_aws, "~> 2.5"},
      {:ex_aws_s3, "~> 2.5"}
    ]
  end
end
