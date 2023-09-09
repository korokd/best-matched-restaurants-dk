defmodule BestMatchedRestaurantsDk.Restaurants do
  alias BestMatchedRestaurantsDk.CsvReader
  alias BestMatchedRestaurantsDk.Restaurants.Restaurant

  @priv_dir :code.priv_dir(:best_matched_restaurants_dk)
  @restaurant_csv_path Path.join([@priv_dir, "csv/restaurants.csv"])

  def list_restaurants(params) do
    read_csv()
    |> filter_by_all(params)
    |> Enum.map(&Restaurant.from_line/1)
    |> Enum.sort(&sort_restaurants/2)
    |> Enum.take(5)
  end

  defp read_csv() do
    @restaurant_csv_path
    |> File.stream!()
    |> CsvReader.parse_stream()
  end

  defp sort_restaurants(%Restaurant{} = r1, %Restaurant{} = r2) do
    distance_comparison = compare(r1.distance, r2.distance)
    customer_rating_comparison = compare(r1.customer_rating, r2.customer_rating)
    price_comparison = compare(r1.price, r2.price)

    case {distance_comparison, customer_rating_comparison, price_comparison} do
      {:lt, _, _} -> true
      {:gt, _, _} -> false
      {:eq, :gt, _} -> true
      {:eq, :lt, _} -> false
      {:eq, :eq, :lt} -> true
      {:eq, :eq, :gt} -> false
      {:eq, :eq, :eq} -> :rand.uniform(2) === 2
    end
  end

  defp filter_by_all(line, %{
         name: name,
         min_rating: min_rating,
         max_distance: max_distance,
         max_price: max_price,
         cuisine_id: cuisine_id
       }) do
    line
    |> Stream.filter(fn line -> filter_line_by_name(line, name) end)
    |> Stream.filter(fn line -> filter_line_by_min_rating(line, min_rating) end)
    |> Stream.filter(fn line -> filter_line_by_max_distance(line, max_distance) end)
    |> Stream.filter(fn line -> filter_line_by_max_price(line, max_price) end)
    |> Stream.filter(fn line -> filter_line_by_cuisine_id(line, cuisine_id) end)
  end

  defp filter_line_by_name(_, nil), do: true

  defp filter_line_by_name([name | _], name_query),
    do: String.contains?(name, name_query)

  defp filter_line_by_min_rating(_, nil), do: true

  defp filter_line_by_min_rating([_, rating | _], min_rating),
    do: rating >= min_rating

  defp filter_line_by_max_distance(_, nil), do: true

  defp filter_line_by_max_distance([_, _, distance | _], max_distance),
    do: distance <= max_distance

  defp filter_line_by_max_price(_, nil), do: true

  defp filter_line_by_max_price([_, _, _, price | _], max_price),
    do: price <= max_price

  defp filter_line_by_cuisine_id(_, nil), do: true

  defp filter_line_by_cuisine_id([_, _, _, _, cuisine_id], cuisine_id_query),
    do: cuisine_id == cuisine_id_query

  defp compare(n1, n2) when n1 > n2, do: :gt
  defp compare(n1, n2) when n1 < n2, do: :lt
  defp compare(_n1, _n2), do: :eq
end
