class RollbackSacodeColumnsIntoTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :service_area_code, :string

    add_column :tickets, :additional_sacode, :string, array: true, default: []
    add_column :tickets, :primary_sacode, :string
  end
end
