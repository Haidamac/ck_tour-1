require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/accommodations', type: :request do
  path '/api/v1/accommodations' do
    get('list accommodations') do
      tags 'Accommodation'
      produces 'application/json'
      parameter name: :geolocations, in: :query, schema: { type: :string },
                description: 'Locality'
      parameter name: :check_in, in: :query, schema: { type: :string },
                description: 'Date of check in'
      parameter name: :check_out, in: :query, schema: { type: :string },
                description: 'Date of check in'
      parameter name: :number_of_peoples, in: :query, schema: { type: :integer },
                description: 'Number of peoples'

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

    post('create accommodation') do
      tags 'Accommodation'
      description 'Creates a new accommodation'
      consumes 'application/json'
      security [ jwt_auth: [] ]
      parameter name: :accommodation,
                in: :body,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    description: { type: :string },
                    address: { type: :string },
                    phone: { type: :string },
                    email: { type: :string, format: :email },
                    kind: { type: :string, enum: [ 'hotel', 'hostel', 'apartment', 'greenhouse' ] },
                    user_id: { type: :string }
                  },
                  required: [ :name, :description, :address, :phone, :email, :kind, :user_id ]
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

  path '/api/v1/accommodations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string, description: 'accommodation id'

    get('show accommodation') do
      tags 'Accommodation'

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
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

    put('update accommodation') do
      tags 'Accommodation'
      consumes 'application/json'
      security [ jwt_auth: [] ]
      parameter name: :accommodation,
                in: :body,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    description: { type: :string },
                    address: { type: :string },
                    phone: { type: :string },
                    email: { type: :string, format: :email },
                    kind: { type: :string, enum: [ 'hotel', 'hostel', 'apartment', 'greenhouse' ] }
                  },
                  required: false
                }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
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

    delete('delete accommodation') do
      tags 'Accommodation'
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
  end

  path '/api/v1/accommodations/{id}/publish' do
    parameter name: :id, in: :path, type: :string, description: 'accommodation id'

    put('publish') do
      tags 'Accommodation'
      consumes 'application/json'
      security [ jwt_auth: [] ]

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
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

  path '/api/v1/accommodations/{id}/unpublish' do
    parameter name: :id, in: :path, type: :string, description: 'accommodation id'

    put('unpublish') do
      tags 'Accommodation'
      consumes 'application/json'
      security [ jwt_auth: [] ]

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
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
