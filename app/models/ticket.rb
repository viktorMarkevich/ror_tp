class Ticket < ApplicationRecord
  has_one :excavator

  validates :request_number, :sequence_number, :request_type, :response_due_date, :service_area_code,
            :digsite_info_wkt, presence: true
  validates :request_number, format: { with: /\A\d+.-\d+\z/,
                                       message: 'should contain only numbers and `-` symbol.' }
  validates :sequence_number, format: { with: /\A\d+\z/,
                                        message: 'should contain only numbers.' }
  validate :validate_service_area_code

  private

  def validate_service_area_code
    if service_area_code && service_area_code.split(', ').detect{ |d| !/\A[A-Z]{1,4}\d{1,3}\z/.match(d) }.present?
      errors.add(:service_area_code, 'please, use uppercase alphabetic and numbers symbols only.')
    end
  end
end
