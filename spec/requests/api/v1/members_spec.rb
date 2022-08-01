# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Members', type: :request do
  get 'Get Members Pagination' do
    path '/api/v1/members' do
      response '200', 'ok' do
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: 'Authorization', in: :header, type: :string

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

  post 'Create Member' do
    path '/api/v1/members' do
      response '201', 'member created' do
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: :member, in: :body, schema: {
          type: :object,
          properties: {
            description: { type: :string },
            facebook_url: { type: :string },
            instagram_url: { type: :string },
            linkedin_url: { type: :string },
            name: { type: :string },
            image: { type: :string }
          },
          required: %w[name]
        }
        parameter name: 'Authorization', in: :header, type: :string

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

  put 'Update Member' do
    path '/api/v1/members/{id}' do
      response '200', 'member updated' do
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: :member, in: :body, schema: {
          type: :object,
          properties: {
            description: { type: :string },
            facebook_url: { type: :string },
            instagram_url: { type: :string },
            linkedin_url: { type: :string },
            name: { type: :string },
            image: { type: :string }
          },
          required: %w[name]
        }

        parameter name: 'Authorization', in: :header, type: :string
        let(:id) { member.id }

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

  delete 'Delete Member' do
    path '/api/v1/members/{id}' do
      response '200', 'member deleted' do
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: 'Authorization', in: :header, type: :string
        let(:id) { member.id }

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
