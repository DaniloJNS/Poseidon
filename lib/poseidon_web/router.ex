defmodule PoseidonWeb.Router do
  use PoseidonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PoseidonWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: PoseidonWeb.ApiSpec
  end

  # Exige "authorization: Bearer <jwt>" e atribui :current_user
  pipeline :auth do
    plug PoseidonWeb.Plugs.Auth
  end

  scope "/", PoseidonWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", PoseidonWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/login", SessionController, :create
  end

  scope "/api", PoseidonWeb do
    pipe_through [:api, :auth]

    resources "/projects", ProjectController, except: [:new, :edit]
  end

  # Documentação. Sem o alias PoseidonWeb no scope, senão vira PoseidonWeb.OpenApiSpex...
  scope "/api" do
    pipe_through :api

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/" do
    pipe_through :browser

    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi"
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:poseidon, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PoseidonWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
