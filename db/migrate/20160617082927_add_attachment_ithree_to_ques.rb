class AddAttachmentIthreeToQues < ActiveRecord::Migration
  def self.up
    change_table :ques do |t|
      t.attachment :ithree
    end
  end

  def self.down
    remove_attachment :ques, :ithree
  end
end
