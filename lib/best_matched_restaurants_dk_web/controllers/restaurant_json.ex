defmodule BestMatchedRestaurantsDkWeb.RestaurantJSON do
  alias BestMatchedRestaurantsDk.Restaurants.Restaurant

  @doc """
  Renders a list of restaurants.
  """
  def index(%{restaurants: restaurants}) do
    %{data: for(restaurant <- restaurants, do: data(restaurant))}
  end

  @doc """
  Renders a single restaurant.
  """
  def show(%{restaurant: restaurant}) do
    %{data: data(restaurant)}
  end

  defp data(%Restaurant{} = restaurant) do
    %{
      name: restaurant.name,
      customer_rating: restaurant.customer_rating,
      distance: restaurant.distance,
      price: restaurant.price,
      cuisine_id: restaurant.cuisine_id
    }
  end
end
