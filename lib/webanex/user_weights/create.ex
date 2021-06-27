defmodule Wabanex.UserWeights.Create do
  alias Wabanex.{Repo, UserWeight, User}
  alias Wabanex.Users.Get


  def call(params) do
    {:ok, %User{height: user_height, id: user_id}} = Get.call(params.user_id)
    params = %{
      user_id: user_id,
      weight: params.weight,
      imc: params.weight / (user_height*user_height)
    }
    params
    |> UserWeight.changeset()
    |> Repo.insert()

  end
end
