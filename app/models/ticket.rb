class Ticket < ApplicationRecord

  validates :request_number, :sequence_number, :request_type, :response_due_date, :primary_sacode, :additional_sacode,
            :digsite_info_wkt, presence: true
  validates :request_number, format: { with: /\A\d+.-\d+\z/,
                                       message: 'should contain only numbers and `-` symbol.' }
  validates :sequence_number, format: { with: /\A\d+\z/,
                                        message: 'should contain only numbers.' }
  validates :primary_sacode, format: { with: /\A[A-Z]{4}\d{3}\z/,
                                       message: 'please use uppercase alphabetic and numbers symbols only.' }
  validate :validate_additional_sacode

  private

  def validate_additional_sacode
    if !additional_sacode.is_a?(Array) || additional_sacode.detect{|d| !/\A[A-Z]{3}\d{2}\z/.match(d)}.present?
      errors.add(:additional_sacode, 'please use uppercase alphabetic and numbers symbols only for array item.')
    end
  end
end
