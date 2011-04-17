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
    @public_note = notes(:abigo_note_one)
    @private_note = notes(:abigo_note_two)
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

  describe 'with_tag' do
    it 'find public note' do
      Note.find_public_note(@user_abigo.id, @public_note.id).should eq @public_note
    end

    it 'return nil when note is private' do
      Note.find_public_note(@user_abigo.id, @private_note.id).should be_nil
    end
  end

end

