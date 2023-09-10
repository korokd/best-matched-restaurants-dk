defmodule BestMatchedRestaurantsDk.Cuisines.Cuisine do
  @derive {Jason.Encoder, only: [:id, :name]}
  defstruct [:id, :name]

  def from_line([id, name]),
    do: %__MODULE__{
      id: id,
      name: name
    }
end
