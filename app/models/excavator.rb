class Excavator < ApplicationRecord
  belongs_to :ticket

  validates :company_name, :address, presence: true
  validates :crew_on_site, inclusion: { in: [true, false] }
end
