# Use the official Elixir image as a parent image
FROM elixir:1.14-slim

# Install hex, rebar, and Node.js (for Phoenix assets)
RUN mix local.hex --force && \
    mix local.rebar --force

# Set the application directory
WORKDIR /app

# Copy over your mix.exs and mix.lock to fetch the dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get

# Copy the application code and assets
COPY config config
COPY lib lib
COPY priv priv
RUN mix phx.digest

# Set MIX_ENV to prod
ENV MIX_ENV=prod

# Compile the application
RUN mix compile

# Expose the port for Phoenix
EXPOSE 4000

# Command to run when the container starts
CMD ["mix", "phx.server"]
