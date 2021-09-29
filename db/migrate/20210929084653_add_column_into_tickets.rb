class AddColumnIntoTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :service_area_code, :string
  end
end
