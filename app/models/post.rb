class Post < ApplicationRecord
  has_many_attached :uploads

  def uploads_on_disk(i)

    ActiveStorage::Blob.service.send(:path_for, uploads[i].key)


  end
  def uploads_on_disk2(i)

    ActiveStorage::Blob.service.send(:path_for, uploads[i].filename.to_s)


  end
end
