class RenameColumnsNamesInTickets < ActiveRecord::Migration[6.1]
  def change
    rename_column :tickets, :reqponse_due_date, :response_due_date
    rename_column :tickets, :primay_sacode, :primary_sacode
  end
end
