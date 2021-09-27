class Excavator < ApplicationRecord
  validates :company_name, :address, presence: true
  validates :crew_on_site, inclusion: { in: [true, false] }
end
