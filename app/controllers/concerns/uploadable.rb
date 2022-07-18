# frozen_string_literal: true

module Uploadable
  def upload
    name = 'cat5.jpg'
    s3 = Aws::S3::Resource.new(region: 'us-east-1')
    obj = s3.bucket(ENV.fetch('AWS_BUCKET')).object(name)
    obj.upload_file("/home/gastonski/Downloads/#{name}")
    obj.presigned_url(:get)
  end
end
