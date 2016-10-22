class AddStiStore < ActiveRecord::Migration[5.0]
  def change
    add_column :basic_users, :sti_store, :json
  end
end
