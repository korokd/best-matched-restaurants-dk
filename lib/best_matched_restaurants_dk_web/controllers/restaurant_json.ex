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
      customer_rating: int_from_string(restaurant.customer_rating),
      distance: int_from_string(restaurant.distance),
      price: int_from_string(restaurant.price),
      cuisine_id: int_from_string(restaurant.cuisine_id)
    }
  end

  defp int_from_string(string) do
    {num, _} = Integer.parse(string)

    num
  end
end
