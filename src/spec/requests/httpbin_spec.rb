require 'rails_helper'

RSpec.describe 'Httpbin' do
  describe 'GET /api/v1/httpbin' do
    context 'ip' do
      it 'can be got' do
        VCR.use_cassette 'api/v1/httpbin' do
          get api_v1_httpbin_path

          assert_response_schema_confirm 200
          expect(response).to have_http_status(:success)

          data = response.parsed_body
          expect(data['ip']).to eq('157.147.142.112')
        end
      end
    end
  end
end
