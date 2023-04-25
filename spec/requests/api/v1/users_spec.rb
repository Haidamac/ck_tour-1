require 'rails_helper'
require 'swagger_helper'
require_relative '../../../../app/controllers/concerns/json_web_token'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do
    get('list users') do
      tags 'Users Admin'
      produces 'application/json'
      security [jwt_auth: []]
      parameter name: :role, in: :query, schema: { type: :string },
                description: 'admin/partner/tourist'

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

    post('create user') do
      tags 'Users Tourist'
      consumes 'application/json'
      parameter name: :user,
                in: :body,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    email: { type: :string },
                    password: { type: :string }
                  },
                  required: %i[name email password]
                }

      response(201, 'successful created') do
        let(:user) { { name: 'John', email: 'john@example.com', password: 'Password123!' } }

        it 'should returns status response' do
          expect(response.status).to eq(201)
        end

        run_test!
      end

      response(422, 'invalid request') do
        let(:user) { { name: '', email: '', password: '' } }
        it 'should returns status response' do
          expect(response.status).to eq(422)
        end

        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string, description: 'user id'
    let(:user) { create(:user) }
    let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secret_key_base) }
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }
    let(:id) { user.id }

    get('show user') do
      tags 'Users'
      parameter name: :Authorization, in: :header, type: :string
      security [jwt_auth: []]

      response(200, 'successful') do
        before do
          user.save
        end

        let(:Authorization) { headers['Authorization'] }

        it 'should returns status response' do
          expect(response.status).to eq(200)
        end

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }

        it 'should returns status response' do
          expect(response.status).to eq(401)
        end

        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:Authorization) { headers['Authorization'] }
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end

        run_test!
      end
    end

    put('change_role') do
      tags 'Users'
      consumes 'application/json'
      security [jwt_auth: []]

      response(200, 'successful') do
        before do
          user.save
        end

        let(:Authorization) { headers['Authorization'] }

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

      response(401, 'unauthorized') do
        let(:Authorization) { headers['invalid'] }

        it 'should returns status response' do
          expect(response.status).to eq(401)
        end

        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:Authorization) { headers['Authorization'] }

        it 'should returns status response' do
          expect(response.status).to eq(404)
        end

        run_test!
      end
    end

    delete('delete user') do
      tags 'Users'
      security [jwt_auth: []]

      response(204, 'no content') do
        let(:Authorization) { headers['Authorization'] }

        it 'should returns status response' do
          expect(response.status).to eq(204)
        end

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }

        it 'should returns status response' do
          expect(response.status).to eq(401)
        end

        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:Authorization) { headers['Authorization'] }

        it 'should returns status response' do
          expect(response.status).to eq(404)
        end

        run_test!
      end
    end
  end
end
