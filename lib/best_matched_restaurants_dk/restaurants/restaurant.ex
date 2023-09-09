defmodule BestMatchedRestaurantsDk.Restaurants.Restaurant do
  alias BestMatchedRestaurantsDk.Utils

  defstruct [:name, :customer_rating, :distance, :price, :cuisine_id]

  def from_line([name, customer_rating, distance, price, cuisine_id]),
    do: %__MODULE__{
      name: name,
      customer_rating: Utils.int_from_string(customer_rating),
      distance: Utils.int_from_string(distance),
      price: Utils.int_from_string(price),
      cuisine_id: cuisine_id
    }
end
