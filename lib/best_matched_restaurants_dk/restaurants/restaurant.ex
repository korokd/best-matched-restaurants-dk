defmodule BestMatchedRestaurantsDk.Restaurants.Restaurant do
  alias BestMatchedRestaurantsDk.Utils
  alias BestMatchedRestaurantsDk.Cuisines

  defstruct [:name, :customer_rating, :distance, :price, :cuisine]

  def from_line([name, customer_rating, distance, price, cuisine_id]),
    do: %__MODULE__{
      name: name,
      customer_rating: Utils.int_from_string(customer_rating),
      distance: Utils.int_from_string(distance),
      price: Utils.int_from_string(price),
      cuisine: Cuisines.get_cuisine(cuisine_id)
    }
end
