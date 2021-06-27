defmodule Wabanex.Users.Update do

  #import Ecto.Query

  alias Wabanex.{Repo, User}



  def call(params) do
    Repo.get!(User, params.id)
    |> User.changeset(params)
    |>Repo.update()
  end

end
