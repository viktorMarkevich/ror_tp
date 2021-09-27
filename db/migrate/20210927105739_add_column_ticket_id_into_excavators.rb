class AddColumnTicketIdIntoExcavators < ActiveRecord::Migration[6.1]
  def change
    add_column :excavators, :ticket_id, :bigint
    add_index :excavators, :ticket_id
  end
end
