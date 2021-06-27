defmodule WabanexWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Weight


  @desc "Logic user representation"
  object :user do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :trainings, list_of(:training)
    field :weights, list_of(:user_weight)
    field :birthday_date, :string
    field :height, :float
  end

  input_object :create_user_input do
    field :name, non_null(:string), description: "Users name"
    field :email, non_null(:string), description: "Users email"
    field :password, non_null(:string), description: "Users password"
    field :birthday_date, non_null(:string), description: "Users birthday date"
    field :height, non_null(:float), description: "Users height"
  end

  input_object :update_user_input do
    field :name, (:string), description: "Users name"
    field :id, (:string), description: "Users id"
    field :password, (:string), description: "Users password"
    field :birthday_date, (:string), description: "Users birthday date"
    field :height, (:float), description: "Users height"
  end

end
