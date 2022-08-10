require 'swagger_helper'

RSpec.describe 'organization', type: :request do
    let(:login_user) do
        create(:user, password: 'password')
        post api_v1_auth_login_path,
             params: { user: { email: User.last.email, password: 'password' } }, as: :json
        JSON.parse(response.body, symbolize_names: true)
      end
    
      let(:Authorization) { login_user[:token] }
        before do
        ENV['JWT_SECRET_KEY'] = 'secret_key'
      end

path '/api/v1/organizations/{id}/public' do
    

    get('shows an organization') do
      response(200, 'successful') do
        let(:id) { '1' }

        tags 'Organizations'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: 'Authorization', in: :header, type: :string
        parameter name: 'id', in: :path, type: :string, description: 'id'
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
    # You'll want to customize the parameter types...
    parameter name: :Authorization, in: :header, type: :string
    

    put('update person') do
      response(200, 'successful') do
        let(:id) { '1' }

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