# Build stage
FROM hexpm/elixir:1.18.2-erlang-26.2.5.9-alpine-3.19.7 AS builder
WORKDIR /app

RUN mix local.hex --force && \
  mix local.rebar --force


COPY . .
RUN mix deps.get

ENV MIX_ENV=prod

RUN mix compile && \
  mix escript.build

# Runtime stage
FROM hexpm/elixir:1.18.2-erlang-26.2.5.9-alpine-3.19.7

COPY --from=builder /app/uncooked_gps /usr/local/bin/uncooked_gps

ENTRYPOINT ["/usr/local/bin/uncooked_gps"]
