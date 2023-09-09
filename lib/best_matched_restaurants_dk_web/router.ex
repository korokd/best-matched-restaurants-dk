defmodule BestMatchedRestaurantsDkWeb.Router do
  use BestMatchedRestaurantsDkWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BestMatchedRestaurantsDkWeb do
    pipe_through :api
  end

  scope "/api/restaurants", BestMatchedRestaurantsDkWeb do
    pipe_through :api

    get "/", RestaurantController, :index
  end
end
