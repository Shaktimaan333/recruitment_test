class AddAttachmentIfourToQues < ActiveRecord::Migration
  def self.up
    change_table :ques do |t|
      t.attachment :ifour
    end
  end

  def self.down
    remove_attachment :ques, :ifour
  end
end
