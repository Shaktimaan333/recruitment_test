class AddAttachmentIquesToQues < ActiveRecord::Migration
  def self.up
    change_table :ques do |t|
      t.attachment :iques
    end
  end

  def self.down
    remove_attachment :ques, :iques
  end
end
