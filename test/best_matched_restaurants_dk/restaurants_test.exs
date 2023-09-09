defmodule BestMatchedRestaurantsDk.RestaurantsTest do
  use ExUnit.Case

  alias BestMatchedRestaurantsDk.Restaurants

  describe "list_restaurants/1" do
    test "returns 5 restaurants" do
      restaurants =
        Restaurants.list_restaurants(%{
          name: nil,
          min_rating: nil,
          max_distance: nil,
          max_price: nil,
          cuisine_id: nil
        })

      assert length(restaurants) == 5
    end

    test "returns only restaurants within given distance" do
      restaurants =
        Restaurants.list_restaurants(%{
          name: nil,
          min_rating: nil,
          max_distance: 5,
          max_price: nil,
          cuisine_id: nil
        })

      restaurants
      |> Enum.all?(fn r -> r.distance <= 5 end)
      |> assert
    end

    test "returns only restaurants within given customer_rating" do
      restaurants =
        Restaurants.list_restaurants(%{
          name: nil,
          min_rating: 3,
          max_distance: nil,
          max_price: nil,
          cuisine_id: nil
        })

      restaurants
      |> Enum.all?(fn r -> r.customer_rating >= 3 end)
      |> assert
    end

    test "returns only restaurants within given price" do
      restaurants =
        Restaurants.list_restaurants(%{
          name: nil,
          min_rating: nil,
          max_distance: nil,
          max_price: 40,
          cuisine_id: nil
        })

      restaurants
      |> IO.inspect()
      |> Enum.all?(fn r -> r.price <= 40 end)
      |> assert
    end

    test "returns only restaurants that belong to the given cuisine_id" do
      restaurants =
        Restaurants.list_restaurants(%{
          name: nil,
          min_rating: nil,
          max_distance: nil,
          max_price: nil,
          cuisine_id: 1
        })

      restaurants
      |> Enum.all?(fn r -> r.cuisine_id == 1 end)
      |> assert
    end
  end

  test "returns only restaurants that match (at least partially) the given name" do
    restaurants =
      Restaurants.list_restaurants(%{
        name: "Ho",
        min_rating: nil,
        max_distance: nil,
        max_price: nil,
        cuisine_id: 1
      })

    restaurants
    |> Enum.all?(fn r -> String.contains?(r.name, "Ho") end)
    |> assert
  end

  test "returns only restaurants that match all given parameters" do
    restaurants =
      Restaurants.list_restaurants(%{
        name: nil,
        min_rating: 4,
        max_distance: 1,
        max_price: 10,
        cuisine_id: "11"
      })

    assert length(restaurants) > 0

    restaurants
    |> Enum.all?(fn r ->
      r.customer_rating >= 4 && r.distance <= 1 && r.price <= 10 && r.cuisine_id == "11"
    end)
    |> assert
  end
end
