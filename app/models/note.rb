class Note < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :tags
  acts_as_textiled :text
  validates_presence_of :text
    
  def self.find_my_notes(current_user_id)
    all(:conditions => "notes.user_id = #{current_user_id}",:order=>"id DESC")
  end
end
