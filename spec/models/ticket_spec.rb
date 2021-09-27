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
      it { expect(invalid_ticket).to validate_presence_of(:response_due_date) }
      it { expect(invalid_ticket).to validate_presence_of(:primary_sacode) }
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
      
      context 'when test primary_sacode' do
        it 'returns invalid for for "-" symbol' do
          expect(valid_ticket).not_to allow_value('ZZG-L103').for(:primary_sacode)
                                      .with_message('please use uppercase alphabetic and numbers symbols only.')
        end

        it 'returns invalid for for " " symbol' do
          expect(valid_ticket).not_to allow_value('ZZ GL103').for(:primary_sacode)
                                      .with_message('please use uppercase alphabetic and numbers symbols only.')
        end

        it 'returns invalid for for lowercase symbol' do
          expect(valid_ticket).not_to allow_value('ZzgL103').for(:primary_sacode)
                                      .with_message('please use uppercase alphabetic and numbers symbols only.')
        end

        it 'returns VALID for for lowercase symbol' do
          expect(valid_ticket).to allow_value('ZZGL103').for(:primary_sacode)
        end
      end
      
      context 'when test additional_sacode' do
        it 'returns invalid for for "-" symbol' do
          expect(valid_ticket).not_to allow_value(%w[ZZL01 ZZL-02 ZZL03]).for(:additional_sacode)
                                      .with_message('please use uppercase alphabetic and numbers symbols only for array item.')
        end

        it 'returns invalid for for " " symbol' do
          expect(valid_ticket).not_to allow_value(%w[ZZL01 ZZL 02 ZZL03]).for(:additional_sacode)
                                      .with_message('please use uppercase alphabetic and numbers symbols only for array item.')
        end

        it 'returns invalid for for lowercase symbol' do
          expect(valid_ticket).not_to allow_value(%w[ZZL01 Zzl02 ZZL03]).for(:additional_sacode)
                                      .with_message('please use uppercase alphabetic and numbers symbols only for array item.')
        end

        it 'returns VALID for for lowercase symbol' do
          expect(valid_ticket).to allow_value(%w[ZZL01 ZZL02 ZZL03]).for(:additional_sacode)
        end
      end
    end
  end
end
