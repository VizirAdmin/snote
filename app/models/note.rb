class Note < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :tags
  acts_as_textiled :text
  validates_presence_of :text

  def self.find_my_notes(current_user_id)
    all(:conditions => "notes.user_id = #{current_user_id}",:order=>"id DESC")
  end

  def self.find_all_tags(notes)
    tags = []
    notes.each do |note|
      note.tags.each{|tag| tags << tag.name if !tags.include?(tag.name)}
    end
    tags
  end

  def self.with_tag(tag, current_user_id)
    find_by_sql(["
      SELECT * FROM notes n
      INNER JOIN taggings ta ON ta.taggable_id = n.id
      INNER JOIN tags t ON ta.tag_id = t.id
      WHERE t.name LIKE ?
      AND n.user_id = ?", "%#{eval("tag")}%", current_user_id])
  end
end

