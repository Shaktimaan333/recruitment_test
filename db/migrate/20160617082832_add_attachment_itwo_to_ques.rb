class AddAttachmentItwoToQues < ActiveRecord::Migration
  def self.up
    change_table :ques do |t|
      t.attachment :itwo
    end
  end

  def self.down
    remove_attachment :ques, :itwo
  end
end
