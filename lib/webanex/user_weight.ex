defmodule Wabanex.UserWeight do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @fields [ :weight, :imc]

  schema "user_weights" do
    field :weight, :float
    field :imc, :float

    belongs_to :user, User
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

  def changeset(weight, params) do
    #IO.inspect(weight)
    #IO.inspect(params)
    weight
    |> cast(params, @fields)
    |> validate_required(@fields)

  end

  def calculateIMC(params) do
    if Map.has_key?(params, :weights) do
      weight = List.first(params.weights).weight
      weights = [%{weight: weight, imc: weight / (params.height * params.height)}]

      Map.replace!(params, :weights, weights)
    else
      params
    end
  end
end
