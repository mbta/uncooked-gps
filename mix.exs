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
      # used by ex_aws to parse AWS CLI settings/credentials
      {:configparser_ex, "5.0.1", only: :dev},
      {:credo, "1.7.19", only: [:dev, :test], runtime: false},
      {:dialyxir, "1.4.8", only: [:dev, :test], runtime: false},
      {:req, "0.7.4"},
      {:tz, "0.28.4"},
      {:mock, "0.3.9", only: :test},
      {:ex_aws, "2.7.0"},
      {:ex_aws_s3, "2.5.9"}
    ]
  end
end
