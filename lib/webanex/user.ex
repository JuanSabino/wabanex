defmodule Wabanex.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.{Training, UserWeight}

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:email, :password, :name, :birthday_date, :height]
  @updateFields [:id, :password, :name, :birthday_date, :height]

  schema "users" do

    field :email, :string
    field :name, :string
    field :password, :string

    field :birthday_date, :date
    field :height, :float
    has_many :weights, UserWeight

    has_many :trainings, Training

    timestamps()
  end

  def changeset(params) do

    params = Wabanex.UserWeight.calculateIMC(params)

    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> cast_assoc(:weights)
  end

  #TODO: Corrigir validação
  def changeset(user, params) do
    #%__MODULE__{}
    cast(user, params, @updateFields)
    #|> validate_required([:id])
    #|> validate_length(:password, min: 6)
    #|> validate_length(:name, min: 2)
    #|> validate_format(:email, ~r/@/)
    #|> unique_constraint([:email])
  end
end
