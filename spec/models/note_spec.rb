require 'spec_helper'

describe Note do

  fixtures :notes, :users

  def create_tags
    notes = Note.all
    notes.each do |n|
      n.tag_list = "user_id_#{n.user_id}"
      n.save
    end
  end

  before(:all) do
    create_tags
  end

  before(:each) do
    @user_abigo = users(:abigo)
  end

  describe 'find_my_notes' do

    it 'find only notes of one user' do
      notes = Note.find_my_notes(@user_abigo.id)
      notes.each {|n| n.user_id.should eq @user_abigo.id}
    end

  end

  describe 'find_all_tags' do
    it 'find all tags that an user has' do
      notes = Note.find_my_notes(@user_abigo.id)
      Note.find_all_tags(notes).first.should eq "user_id_#{@user_abigo.id}"
    end
  end

  describe 'with_tag' do
    it 'find all notes with a specific tag and of only one user' do
      notes = Note.with_tag("user_id_#{@user_abigo.id}", @user_abigo.id)
      notes.each do |n|
        n.user_id.should eq @user_abigo.id
        n.tags.first eq "user_id_#{@user_abigo.id}"
      end
    end
  end

end

