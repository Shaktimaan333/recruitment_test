class AddAttachmentTryimageToHeadshotPhotos < ActiveRecord::Migration
  def self.up
    change_table :headshot_photos do |t|
      t.attachment :tryimage
    end
  end

  def self.down
    remove_attachment :headshot_photos, :tryimage
  end
end
