# frozen_string_literal: true

class CommentsSerializer
  include JSONAPI::Serializer

  attributes :body
end
