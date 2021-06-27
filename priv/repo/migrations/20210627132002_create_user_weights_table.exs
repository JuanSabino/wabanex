defmodule Wabanex.Repo.Migrations.CreateUserWeightsTable do
  use Ecto.Migration

  def change do
    create table(:user_weights) do
      add :user_id, references(:users)
      add :weight, :float
      add :imc, :float
      timestamps()
    end
  end
end
