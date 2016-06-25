class AddAttachmentIoneToQues < ActiveRecord::Migration
  def self.up
    change_table :ques do |t|
      t.attachment :ione
    end
  end

  def self.down
    remove_attachment :ques, :ione
  end
end
