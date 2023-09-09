defmodule BestMatchedRestaurantsDk.Restaurants.Restaurant do
  defstruct [:name, :customer_rating, :distance, :price, :cuisine_id]

  def from_line([name, customer_rating, distance, price, cuisine_id]),
    do: %__MODULE__{
      name: name,
      customer_rating: customer_rating,
      distance: distance,
      price: price,
      cuisine_id: cuisine_id
    }
end
