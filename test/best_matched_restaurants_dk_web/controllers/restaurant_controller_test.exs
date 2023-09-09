defmodule BestMatchedRestaurantsDkWeb.RestaurantControllerTest do
  alias BestMatchedRestaurantsDk.Restaurants.Restaurant
  use BestMatchedRestaurantsDkWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists 5 restaurants", %{conn: conn} do
      conn = get(conn, ~p"/api/restaurants")
      assert length(json_response(conn, 200)["data"]) == 5
    end

    test "lists only restaurants that match the given parameters", %{conn: conn} do
      conn =
        get(conn, ~p"/api/restaurants", %{
          name: nil,
          min_rating: "4",
          max_distance: "1",
          max_price: "10",
          cuisine_id: "11"
        })

      response = json_response(conn, 200)
      data = response["data"]
      [restaurant | _] = data

      assert length(data) == 1

      assert %{
               "name" => _,
               "customer_rating" => 4,
               "distance" => 1,
               "price" => 10,
               "cuisine_id" => 11
             } = restaurant
    end
  end
end
