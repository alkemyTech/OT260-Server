# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Slides API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:slide) { create(:slide) }

  path '/api/v1/slides' do
    get('Get All Slides') do
      response(200, 'successful') do
        tags 'Slides'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 slides: {
                   type: :array,
                   items: {
                     properties: {
                       text: { type: :string, nullable: true },
                       order: { type: :integer, nullable: true },
                       organization_id: { type: :integer }
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

    post('Create Slide') do
      response(201, 'created') do
        tags 'Slides'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :slide, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string, nullable: true },
            order: { type: :integer, nullable: true }
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
  end

  path '/api/v1/slides/{id}' do
    get('Show Slides') do
      response(200, 'succesful') do
        let(:id) { '123' }
        tags 'Slides'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        schema type: :object,
               properties: {
                 slides: {
                   type: :array,
                   items: {
                     properties: {
                       text: { type: :string, nullable: true },
                       order: { type: :integer, nullable: true }
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

    put('Update Slide') do
      response(200, 'updated successfully') do
        let(:id) { '123' }
        tags 'Slides'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :slide, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string, nullable: true },
            order: { type: :integer, nullable: true }
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

    delete('Delete Slide') do
      response(200, 'deleted successfully') do
        let(:id) { '1' }
        tags 'Slides'
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
