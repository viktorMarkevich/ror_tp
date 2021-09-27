class Ticket < ApplicationRecord

  validates :request_number, :sequence_number, :request_type, :reqponse_due_date, :primay_sacode, :additional_sacode,
            :digsite_info_wkt, presence: true
  validates :request_number, format: { with: /\A\d+.-\d+\z/,
                                       message: 'should contain only numbers and `-` symbol.' }
end
