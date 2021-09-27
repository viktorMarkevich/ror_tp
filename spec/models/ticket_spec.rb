require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'has a valid factory' do
    expect(build(:ticket)).to be_valid
  end

  context 'when test validation' do
    let(:ticket) { build :ticket, :invalid_data }

    context 'when test basic validations' do
      it { expect(ticket).to validate_presence_of(:request_number) }
      it { expect(ticket).to validate_presence_of(:sequence_number) }
      it { expect(ticket).to validate_presence_of(:request_type) }
      it { expect(ticket).to validate_presence_of(:reqponse_due_date) }
      it { expect(ticket).to validate_presence_of(:primay_sacode) }
      it { expect(ticket).to validate_presence_of(:additional_sacode) }
      it { expect(ticket).to validate_presence_of(:digsite_info_wkt) }
    end

    context 'when test format validations' do
      xit { expect(ticket).not_to allow_value('09jdfk252012-00001').for(:request_number) }
    end
  end
end
