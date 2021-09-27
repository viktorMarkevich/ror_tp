require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'has a valid factory' do
    expect(build(:ticket)).to be_valid
  end

  context 'when test validation' do
    let(:invalid_ticket) { build :ticket, :invalid_data }

    context 'when test basic validations' do
      it { expect(invalid_ticket).to validate_presence_of(:request_number) }
      it { expect(invalid_ticket).to validate_presence_of(:sequence_number) }
      it { expect(invalid_ticket).to validate_presence_of(:request_type) }
      it { expect(invalid_ticket).to validate_presence_of(:reqponse_due_date) }
      it { expect(invalid_ticket).to validate_presence_of(:primay_sacode) }
      it { expect(invalid_ticket).to validate_presence_of(:additional_sacode) }
      it { expect(invalid_ticket).to validate_presence_of(:digsite_info_wkt) }
    end

    context 'when test format validations' do
      let(:valid_ticket) { build :ticket }

      context 'when test request_number' do
        it 'returns invalid for alphabetic symbols' do
          expect(valid_ticket).not_to allow_value('09jdfk252012-00001').for(:request_number)
                                .with_message('should contain only numbers and `-` symbol.')
        end

        it 'returns invalid for whitespace symbols' do
          expect(valid_ticket).not_to allow_value('09 252012-00001').for(:request_number)
                                .with_message('should contain only numbers and `-` symbol.')
        end

        it 'receives the valid value' do
          expect(valid_ticket).to allow_value('09252012-00001').for(:request_number)
        end
      end
    end
  end
end
