require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/rates', type: :request do

  path '/api/v1/{parentable_type}/{parentable_id}/rates' do
    parameter name: 'parentable_type', in: :path, type: :string, description: 'f.e. attractions, accommodations, caterings, tours'
    parameter name: 'parentable_id', in: :path, type: :string, description: 'f.e. attraction_id, accommodation_id, catering_id, tour_id'

    get('averedge rate for all') do
      tags 'Rate'
      produces 'application/json'
      security [ jwt_auth: [] ]

      response(200, 'successful') do
        it 'should returns status response' do
          expect(response.status).to eq(200)
        end
      end

      response(401, 'unauthorized') do
        it 'should returns status response' do
          expect(response.status).to eq(401)
        end
      end

      response(404, 'not found') do
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end
      end

      response(422, 'invalid request') do
        it 'should returns status response' do
          expect(response.status).to eq(422)
        end
      end
    end

    post('create rate by authenticated user') do
      tags 'Rate'
      consumes 'application/json'
      security [ jwt_auth: [] ]
      parameter name: :rate,
                in: :body,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    rating: { type: :integer }
                  },
                  required: %i[body]
                }

      response(201, 'successful created') do
        it 'should returns status response' do
          expect(response.status).to eq(201)
        end
      end

      response(401, 'unauthorized') do
        it 'should returns status response' do
          expect(response.status).to eq(401)
        end
      end

      response(404, 'not found') do
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end
      end

      response(422, 'invalid request') do
        it 'should returns status response' do
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path '/api/v1/{parentable_type}/{parentable_id}/rates/{id}' do
    parameter name: 'parentable_type', in: :path, type: :string, description: 'f.e. attractions, accommodations, caterings, tours'
    parameter name: 'parentable_id', in: :path, type: :string, description: 'f.e. attraction_id, accommodation_id, catering_id, tour_id'
    parameter name: :id, in: :path, type: :string, description: 'rate id'

    get('show rate for all') do
      tags 'Rate'
      security [ jwt_auth: [] ]

      response(200, 'successful') do
        let(:rate_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(200, 'successful') do
        it 'should returns status response' do
          expect(response.status).to eq(200)
        end
      end

      response(404, 'not found') do
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end
      end

      response(422, 'invalid request') do
        it 'should returns status response' do
          expect(response.status).to eq(422)
        end
      end
    end

    put('update rate by authenticated user or admin') do
      tags 'Rate'
      consumes 'application/json'
      security [ jwt_auth: [] ]
      parameter name: :rate,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    rating: { type: :integer }
                  },
                  required: %i[body]
                }

      response(200, 'successful') do
        let(:rate_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'unauthorized') do
        it 'should returns status response' do
          expect(response.status).to eq(401)
        end
      end

      response(404, 'not found') do
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end
      end

      response(422, 'invalid request') do
        it 'should returns status response' do
          expect(response.status).to eq(422)
        end
      end
    end

    delete('delete rate by admin') do
      tags 'Rate'
      security [ jwt_auth: [] ]

      response(200, 'successful') do
        let(:rate_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(200, 'successful') do
        it 'should returns status response' do
          expect(response.status).to eq(200)
        end
      end

      response(401, 'unauthorized') do
        it 'should returns status response' do
          expect(response.status).to eq(401)
        end
      end

      response(404, 'not found') do
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end
      end

      response(422, 'invalid request') do
        it 'should returns status response' do
          expect(response.status).to eq(422)
        end
      end
    end
  end
end