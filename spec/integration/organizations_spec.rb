# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'organization' do
    let(:login_user) do
        create(:user, password: 'password')
        post api_v1_auth_login_path,
             params: { user: { email: User.last.email, password: 'password' } }, as: :json
        JSON.parse(response.body, symbolize_names: true)
      end
    
      let(:Authorization) { login_user[:token] }

      
path '/api/v1/organizations/{id}/public' do
    get('shows an organization') do
      response(200, 'successful') do
        let(:id) { '123' }
        tags 'Organizations'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string, description: 'id'
        schema type: :object,
               properties: {
                 organizations: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       about_us_text: { type: :text, nullable: true },
                       address: { type: :string, nullable: true },
                       email: { type: :string },
                       name: { type: :string },
                       facebook_url: { type: :string, nullable: true },
                       linkedin_url: { type: :string, nullable: true },
                       instagram_url: { type: :string, nullable: true },
                       phone: {type: :integer, nullable: true },
                       welcome_text: {type: :text}
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

  path '/api/v1/organizations/{id}' do

    put('updates an organization') do
        response(200, 'updated successfully') do
          let(:id) { '123' }
          tags 'Organizations'
          consumes 'application/json'
          security [Bearer: {}]
          parameter name: :Authorization, in: :header, type: :string
          parameter name: :id, in: :path, type: :string
          parameter name: :organization, in: :body, schema: {
          type: :object,
                 properties: {
                         about_us_text: { type: :text, nullable: true },
                         address: { type: :string, nullable: true },
                         email: { type: :string },
                         name: { type: :string },
                         facebook_url: { type: :string, nullable: true },
                         linkedin_url: { type: :string, nullable: true },
                         instagram_url: { type: :string, nullable: true },
                         phone: {type: :integer, nullable: true },
                         welcome_text: {type: :text}
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
  end
end
