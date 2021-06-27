defmodule Wabanex.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :birthday_date, :date
      add :height, :float
    end
  end
end
