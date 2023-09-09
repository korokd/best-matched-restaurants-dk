defmodule BestMatchedRestaurantsDkWeb.RestaurantController do
  use BestMatchedRestaurantsDkWeb, :controller

  alias BestMatchedRestaurantsDk.Utils
  alias BestMatchedRestaurantsDk.Restaurants

  action_fallback BestMatchedRestaurantsDkWeb.FallbackController

  def index(conn, params) do
    name = params["name"]
    min_rating = params["min_rating"]
    max_distance = params["max_distance"]
    max_price = params["max_price"]
    cuisine_id = params["cuisine_id"]

    restaurants =
      Restaurants.list_restaurants(%{
        name: name,
        min_rating: Utils.int_from_string(min_rating),
        max_distance: Utils.int_from_string(max_distance),
        max_price: Utils.int_from_string(max_price),
        cuisine_id: cuisine_id
      })

    render(conn, :index, restaurants: restaurants)
  end
end
