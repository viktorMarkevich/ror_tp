require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'when test validation' do
    let(:invalid_ticket) { build :ticket, :invalid_data }

    it 'has a valid factory' do
      expect(build(:ticket)).to be_valid
    end

    context 'when test basic validations' do
      it { expect(invalid_ticket).to validate_presence_of(:request_number) }
      it { expect(invalid_ticket).to validate_presence_of(:sequence_number) }
      it { expect(invalid_ticket).to validate_presence_of(:request_type) }
      it { expect(invalid_ticket).to validate_presence_of(:response_due_date) }
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

      context 'when test sequence_number' do
        it 'returns invalid for alphabetic symbols' do
          expect(valid_ticket).not_to allow_value('0fd001').for(:sequence_number)
                                      .with_message('should contain only numbers.')
        end

        it 'returns invalid for whitespace symbols' do
          expect(valid_ticket).not_to allow_value('50 01').for(:sequence_number)
                                      .with_message('should contain only numbers.')
        end

        it 'receives the valid value' do
          expect(valid_ticket).to allow_value('4501').for(:sequence_number)
        end
      end

      context 'when test response_due_date' do
        it 'returns invalid for numbers' do
          expect(valid_ticket).not_to allow_value('year/m7/13 2x:59:59').for(:response_due_date)
                                     .with_message("can't be blank")
        end
      end
    end
  end

  context 'when check Associations' do
    it { is_expected.to have_one(:excavator) }
  end

  context 'when methods test' do
    it 'returns an array of coordinates' do
      ticket = build :ticket,
                     digsite_info_wkt: 'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295))'

      expect(ticket.polygon_coordinates).to eq([[32.07206917625161, -81.13390268058475],
                                                [32.04064386441295, -81.14660562247929]])
    end
  end
end
