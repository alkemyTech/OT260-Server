# frozen_string_literal: true

# require 'swagger_helper'

# RSpec.describe 'api/v1/members', type: :request do
#   let(:login_user) do
#     create(:user, password: 'password')
#     post api_v1_auth_login_path,
#          params: { user: { email: User.last.email, password: 'password' } }, as: :json
#     JSON.parse(response.body, symbolize_names: true)
#   end

#   let(:Authorization) { { Authorization: login_user[:token] } }
#   let(:create_members) { create_list(:member, 10) }

#   before { create_members }

#   path '/api/v1/members' do
#     post('create member') do
#       response(200, 'successful') do
#         tags 'Members'
#         consumes 'application/json'
#         produces 'application/json'
#         parameter name: :Authorization, in: :header, type: :string
#         parameter name: :member, in: :body, schema: {
#           type: :object,
#           properties: {
#             name: { type: :string },
#             facebook_url: { type: :string, nullable: true },
#             linkedin_url: { type: :string, nullable: true },
#             instagram_url: { type: :string, nullable: true },
#             description: { type: :string, nullable: true }
#           },
#           required: %w[name]
#         }
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end
# end

#   post('create member') do
#     response(200, 'successful') do
#       after do |example|
#         example.metadata[:response][:content] = {
#           'application/json' => {
#             example: JSON.parse(response.body, symbolize_names: true)
#           }
#         }
#       end

#       run_test!
#     end
#   end

#   path '/api/v1/member/{id}' do
#     # You'll want to customize the parameter types...
#     parameter name: 'id', in: :path, type: :string, description: 'id'

#     put('update member') do
#       response(200, 'successful') do
#         let(:id) { '1' }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end

#     delete('delete member') do
#       response(200, 'successful') do
#         let(:id) { '1' }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end
