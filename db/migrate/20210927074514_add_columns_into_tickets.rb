class AddColumnsIntoTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :request_number, :string
    add_column :tickets, :sequence_number, :string
    add_column :tickets, :request_type, :string
    add_column :tickets, :reqponse_due_date, :datetime, precision: 6, null: false
    add_column :tickets, :primay_sacode, :string
    add_column :tickets, :additional_sacode, :string, array: true
    add_column :tickets, :digsite_info_wkt, :text
  end
end
