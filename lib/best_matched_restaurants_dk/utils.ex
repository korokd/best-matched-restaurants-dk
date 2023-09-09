defmodule BestMatchedRestaurantsDk.Utils do
  @spec int_from_string(binary | nil) :: integer | nil
  def int_from_string(nil), do: nil

  def int_from_string(string) do
    {num, _} = Integer.parse(string)

    num
  end
end
