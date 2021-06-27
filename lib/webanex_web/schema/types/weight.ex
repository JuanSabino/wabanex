defmodule WabanexWeb.Schema.Types.Weight do
  use Absinthe.Schema.Notation

  @desc "Logic user representation"
  object :user_weight do
    field :id, (:uuid4)
    field :imc, (:float)
    field :weight, (:float)
    field :updated_at, (:string)
  end

end
