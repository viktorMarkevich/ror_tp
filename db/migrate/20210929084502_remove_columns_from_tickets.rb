class RemoveColumnsFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :additional_sacode, :string, array: true
    remove_column :tickets, :primary_sacode, :string
  end
end
