# Best Matched Restaurants - DK

## Running

- Make sure you have [Docker](https://www.docker.com/) installed
- Run `docker compose build`
- Run `docker compose run`
- The server should now be running at `http://localhost:4000`
- You can either access it (and the implemented endpoints) in the browser, via CURL, or something else similar

### Implemented endpoints & parameters
- `/api/restaurants` returns a list of the 5 restaurants that best matched the following parameters (all optional):
  - `max_distance`: integer number, sets maximum (inclusive) `distance`
  - `min_rating`: integer number, sets minimum (inclusive) `customer_rating`
  - `max_price`: integer number, sets maximum (inclusive) `price`
  - `cuisine_id`: integer number, determines what the `cuisine_id` must be
  - `name`: string, determines a total or partial query for the restaurant `name`

An example of a full URL for the endpoint above would be `http://localhost:4000/api/restaurants?max_distance=3&cuisine_id=15&min_rating=3&max_price=30`

## Running the tests
### Setup
- Make sure you have [ASDF](https://github.com/asdf-vm/asdf), [ASDF-Erlang](https://github.com/asdf-vm/asdf-erlang), and [ASDF-Elixir](https://github.com/asdf-vm/asdf-elixir) installed
- Run `asdf install` from within the project folder
- Run `mix test`
