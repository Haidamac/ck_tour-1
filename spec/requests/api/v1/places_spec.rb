require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/places', type: :request do
  let!(:user) { create(:user, role: 'partner') }
  let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secret_key_base) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:Authorization) { headers['Authorization'] }
  let!(:tour) { create(:tour, user_id: user.id) }
  let(:tour_id) { tour.id }

  path '/api/v1/tours/{tour_id}/places' do
    parameter name: 'tour_id', in: :path, type: :string, description: 'tour_id'
    get('list places of tour for all') do
      tags 'Tour'
      produces 'application/json'
      security [jwt_auth: []]

      response(200, 'successful') do
        let!(:place) { create(:place, tour_id: tour.id) }

        it 'should returns status response' do
          expect(response.status).to eq(200)
        end

        run_test!
      end
    end

    post('create place for tour by partner') do
      tags 'Partner Tours'
      security [jwt_auth: []]
      consumes 'multipart/form-data'
      parameter name: :place,
                in: :formData,
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    body: { type: :string },
                    image: { type: :file }
                  },
                  required: %i[name body image]
                }

      response(201, 'successful created') do
        let!(:place) { build_stubbed(:place, tour_id: tour.id) }

        run_test! do
          expect(response.status).to eq(201)
          json = JSON.parse(response.body).deep_symbolize_keys
          expect(json[:name]).to eq(place.name)
          expect(json[:body]).to eq(place.body)
        end
      end

      response(401, 'unauthorized') do
        let!(:user) { create(:user) }
        let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secret_key_base) }
        let(:headers) { { 'Authorization' => "Bearer #{token}" } }
        let(:Authorization) { headers['Authorization'] }
        let!(:place) { build_stubbed(:place, tour_id: tour.id) }

        run_test! do
          expect(response.status).to eq(401)
        end
      end

      response(422, 'invalid request') do
        let!(:place) { build_stubbed(:place, tour_id: tour.id, name: nil) }

        run_test! do
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path '/api/v1/tours/{tour_id}/places/{id}' do
    parameter name: 'tour_id', in: :path, type: :string, description: 'tour_id'
    parameter name: 'id', in: :path, type: :string, description: 'place_id'
    let!(:place) { create(:place, tour_id: tour.id) }

    get('show place of tour for all') do
      tags 'Tour'
      security [jwt_auth: []]

      response(200, 'successful') do
        let(:id) { place.id }

        it 'should returns status response' do
          expect(response.status).to eq(200)
        end

        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        it 'should returns status response' do
          expect(response.status).to eq(404)
        end

        run_test!
      end
    end

    put('update place of tour by partner') do
      tags 'Partner Tours'
      consumes 'multipart/form-data'
      security [jwt_auth: []]
      parameter name: :place,
                in: :formData,
                schema: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    body: { type: :string },
                    image: { type: :file }
                  }
                }

      response(200, 'successful') do
        let(:id) { place.id }

        run_test! do
          expect(response.status).to eq(200)
        end

        run_test! do
          place.update(name: 'Machu Picchu')
          expect(Place.find_by(name: 'Machu Picchu')).to eq(place)
          place.update(body: 'Machu Picchu - ancient capital of Inca State')
          expect(Place.find_by(body: 'Machu Picchu - ancient capital of Inca State')).to eq(place)
        end
      end

      response(401, 'unauthorized') do
        let(:id) { place.id }
        let(:Authorization) { nil }

        run_test! do |response|
          data = JSON.parse(response.body)
          place.update(name: 'Machu Picchu')
          expect(response.status).to eq(401)
        end
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:place_attributes) { attributes_for(:place) }

        run_test! do
          expect(response.status).to eq(404)
        end
      end
    end

    delete('delete place of tour by partner') do
      tags 'Partner Tours'
      security [jwt_auth: []]

      response(200, 'successful') do
        let(:id) { place.id }

        run_test! do
          expect(response.status).to eq(200)
        end
      end

      response(401, 'unauthorized') do
        let(:id) { place.id }
        let(:Authorization) { nil }

        run_test! do
          expect(response.status).to eq(401)
        end
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }

        run_test! do
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
