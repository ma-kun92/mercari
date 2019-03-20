class CreditCard < ActiveRecord::Migration[5.0]
  def change
    drop_table :credit_cards
  end
end
