require 'rails_helper'
require 'swagger_helper'

RSpec.describe "Api::V1::Amenities", type: :request do
  path '/api/v1/accommodations/{accommodation_id}/rooms/{room_id}/amenities' do
    # You'll want to customize the parameter types...
    parameter name: 'accommodation_id', in: :path, type: :string, description: 'accommodation_id'
    parameter name: 'room_id', in: :path, type: :string, description: 'room_id'

    get('list amenities') do
      tags 'Amenity'
      response(200, 'successful') do
        let(:accommodation_id) { '123' }

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

    post('create amenity') do
      tags 'Amenity'
      consumes 'application/json'
      security [ jwt_auth: [] ]
      parameter name: :amenity,
                in: :body,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    conditioner: { type: :boolean },
                    tv: { type: :boolean },
                    refrigerator: { type: :boolean },
                    kettle: { type: :boolean },
                    mv_owen: { type: :boolean },
                    hair_dryer: { type: :boolean },
                    nice_view: { type: :boolean },
                    inclusive: { type: :boolean }
                  },
                }

      response(201, 'successful created') do
        let(:accommodation_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

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

  path '/api/v1/accommodations/{accommodation_id}/rooms/{room_id}/amenities/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'accommodation_id', in: :path, type: :string, description: 'accommodation_id'
    parameter name: 'room_id', in: :path, type: :string, description: 'room_id'
    parameter name: 'id', in: :path, type: :string, description: 'amenity_id'

    put('update amenity') do
      tags 'Amenity'
      consumes 'application/json'
      security [ jwt_auth: [] ]
      parameter name: :amenity,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    conditioner: { type: :boolean },
                    tv: { type: :boolean },
                    refrigerator: { type: :boolean },
                    kettle: { type: :boolean },
                    mv_owen: { type: :boolean },
                    hair_dryer: { type: :boolean },
                    nice_view: { type: :boolean },
                    inclusive: { type: :boolean }
                  }
                  # required: false
                }

      response(200, 'successful') do
        let(:accommodation_id) { '123' }
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

    delete('delete amenity') do
      tags 'Amenity'
      security [ jwt_auth: [] ]

      response(200, 'successful') do
        let(:accommodation_id) { '123' }
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
