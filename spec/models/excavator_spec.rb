require 'rails_helper'

RSpec.describe Excavator, type: :model do

  it 'has a valid factory' do
    expect(build(:excavator)).to be_valid
  end

  context 'when test validation' do
    let(:invalid_excavator) { build :excavator, :invalid_data }

    context 'when test basic validations' do
      it { expect(invalid_excavator).to validate_presence_of(:company_name) }
      it { expect(invalid_excavator).to validate_presence_of(:address) }
    end

    context 'when test inclusion for crew_on_site column' do
      let(:valid_excavator) { build :excavator }

      it 'returns invalid for nil' do
        expect(valid_excavator).not_to allow_value(nil).for(:crew_on_site)
                                       .with_message('is not included in the list')
      end

      it 'returns valid for false' do
        expect(valid_excavator).to allow_value(false).for(:crew_on_site)
      end

      it 'returns invalid for true' do
        expect(valid_excavator).to allow_value(true).for(:crew_on_site)
      end
    end
  end
end
