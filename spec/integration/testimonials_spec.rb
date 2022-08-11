# frozen_string_literal: true

require 'swagger_helper'

describe 'Testimonials API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:testimonial) { create(:testimonial) }

  before do
    ENV['JWT_SECRET_KEY'] = 'secret_key'
  end

  path '/api/v1/testimonials' do
    get('Get All Testimonials') do
      response(200, 'successful') do
        tags 'Testimonials'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 testimonials: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       content: { type: :string, nullable: true }
                     }
                   }
                 }
               }

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

    post('Create Testimonials') do
      response(201, 'created') do
        tags 'Testimonials'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :testimonial, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            content: { type: :string, nullable: true }
          },
          required: %w[name]
        }
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

  path '/api/v1/testimonials/{id}' do
    patch('Update Testimonial') do
      response(200, 'updated successfully') do
        let(:id) { '123' }
        tags 'Testimonials'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :testimonial, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            content: { type: :string, nullable: true }
          },
          required: %w[name]
        }

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

    delete('Delete Testimonial') do
      response(200, 'deleted successfully') do
        let(:id) { '1' }
        tags 'Testimonials'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string

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
