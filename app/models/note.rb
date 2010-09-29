class Note < ActiveRecord::Base
  acts_as_taggable_on :tags
  acts_as_textiled :text
  validates_presence_of :text
end
