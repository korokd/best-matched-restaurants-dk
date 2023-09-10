defmodule BestMatchedRestaurantsDk.Cuisines do
  alias BestMatchedRestaurantsDk.CsvReader
  alias BestMatchedRestaurantsDk.Cuisines.Cuisine

  @priv_dir :code.priv_dir(:best_matched_restaurants_dk)
  @cuisines_csv_path Path.join([@priv_dir, "csv/cuisines.csv"])

  def get_cuisine(cuisine_id) do
    [cuisine | _] =
      read_csv()
      |> Stream.filter(fn [id, _name] -> id == cuisine_id end)
      |> Stream.take(1)
      |> Stream.map(&Cuisine.from_line/1)
      |> Enum.to_list()

    cuisine
  end

  defp read_csv() do
    @cuisines_csv_path
    |> File.stream!()
    |> CsvReader.parse_stream()
  end
end
