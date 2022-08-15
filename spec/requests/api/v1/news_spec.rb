# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'news', type: :request do
  let(:user) { create(:normal_user) }
  let(:user_id) { user.id }
  let(:token) { Authenticable.encode(user_id: user_id) }
  let(:good_news) { create(:good_news) }
  let(:bad_news) { create(:bad_news) }

  path '/news/{id}/details' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('details news') do
      tags 'News'
      response(401, 'unauthorized') do
        let(:id) { good_news.id }
        run_test!
      end
      response(404, 'not found') do
        run_test!
      end
      response(200, 'news found') do
        run_test!
      end
    end
  end

  path '/news' do
    post('create news') do
      tags 'News'
      response(201, 'news created') do
        run_test!
      end
    end
  end

  path '/news/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('update news') do
      tags 'News'
      response(401, 'unauthorized') do
        run_test!
      end
      response(404, 'not found') do
        run_test!
      end
      response(200, 'successful') do
        run_test!
      end
    end

    delete('delete news') do
      parameter name: 'id', in: :path, type: :string, description: 'id'
      tags 'News'
      response(401, 'unauthorized') do
        run_test!
      end
      response(200, 'successful') do
        run_test!
      end
      response(404, 'not found') do
        run_test!
      end
      response(422, 'unprocessable_entity') do
        run_test!
      end
    end
  end
end
