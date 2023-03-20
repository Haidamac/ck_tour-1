require 'swagger_helper'

RSpec.describe 'api/v1/accommodations', type: :request do
  path '/api/v1/accommodations' do
    get('list accommodations') do
      tags 'Accommodation'
      produces 'application/json'
      parameter name: :accommodation,
                in: :body,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    toponyms: { type: :string },
                    check_in: { type: :string },
                    check_out: { type: :string },
                    number_of_peoples: { type: :integer }
                  },
                  required: false
                }          

      response(200, 'successful') do
        it 'should returns status response' do
          expect(response.status).to eq(200)
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
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
                    kind: { type: :string, enum: [ 'hotel', 'hostel', 'apartment', 'greenhouse' ] }
                  },
                  required: [ :name, :description, :address, :phone, :email, :kind ]
                }
      
      response(201, 'successful') do
        it 'should returns status response' do
          expect(response.status).to eq(201)
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/accommodations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string, description: 'accommodation id'

    get('show accommodation') do
      tags 'Accommodation'
    
      response(200, 'successful') do
        it 'should returns status response' do
          expect(response.status).to eq(200)
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
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
        run_test!
      end
    end

    delete('delete accommodation') do
      tags 'Accommodation'
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
        run_test!
      end
    end
  end
end
