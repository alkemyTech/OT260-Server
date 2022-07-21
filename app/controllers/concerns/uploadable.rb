# frozen_string_literal: true

<<<<<<< HEAD:app/controllers/concerns/uploadable.rb
module Uploadable
  def upload
    name = 'cat5.jpg'
=======
module UploadService
  def upload(filepath)
    key = File.basename(filepath)
>>>>>>> changed path so that its written in the method instead of writing it manually:app/controllers/concerns/upload_service.rb
    s3 = Aws::S3::Resource.new(region: 'us-east-1')
    obj = s3.bucket(ENV.fetch('AWS_BUCKET')).object(key)
    obj.upload_file(filepath)
    obj.public_url
  end
end
