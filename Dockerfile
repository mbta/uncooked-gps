# Build stage
FROM hexpm/elixir:1.18.2-erlang-26.2.5.9-alpine-3.19.7 AS elixir
WORKDIR /app

RUN mix local.hex --force && \
  mix local.rebar --force


COPY . .
RUN mix deps.get

ENV MIX_ENV=prod

RUN mix compile
RUN mix release --path /app-release

# Runtime stage
FROM hexpm/elixir:1.18.2-erlang-26.2.5.9-alpine-3.19.7 as runtime

COPY --from=elixir /app-release .
CMD ["bin/uncooked_gps", "start"]
