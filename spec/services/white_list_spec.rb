require 'rails_helper'

describe WhiteList do
  describe '#handle_payload' do
    let(:white_list) { described_class.new(ActionController::Parameters.new(payload)) }
    let(:handled_ticket_response) do
      {
        request_number: '09252012-00001',
        sequence_number: '2421',
        request_type: 'Normal',
        response_due_date: '2011/07/13 23:59:59',
        additional_sacode: %w[ZZL01 ZZL02 ZZL03],
        primary_sacode: 'ZZGL103',
        digsite_info_wkt: 'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))'
      }
    end

    let(:handled_excavator_response) do
      {
        company_name: 'John Doe CONSTRUCTION',
        address: '555 Some RD, SOME PARK, ZZ, 55555',
        crew_on_site: 'true'
      }
    end

    context 'with invalid params' do
      it 'return ticket response' do
        expect(white_list.handle_ticket_payload).to eq(handled_ticket_response)
      end

      it 'return excavator response' do
        expect(white_list.handle_excavator_payload).to eq(handled_excavator_response)
      end

      it 'return full handled response' do
        expect(white_list.handle_payload).to eq(handled_ticket_response
                                                            .merge(excavator_attributes: handled_excavator_response))
      end
    end
  end
end
