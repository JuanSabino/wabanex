defmodule Webanex.Users.Create do
  alias Webanex.{Repo, User}


  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()

  end
end
