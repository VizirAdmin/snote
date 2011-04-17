# coding: utf-8
class NotesController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  layout :choose_layout

  def index
    @search = params[:search]
    if @search.blank?
      @notes = Note.find_my_notes(current_user.id)
    else
      @notes = Note.with_tag(@search, current_user.id)
    end
    @user_name = current_user.username.downcase
    @tags = Note.find_all_tags(@notes)
    respond_to do |format|
      format.js if request.xhr?
      format.html
    end
  end

  def show
    user_username = params[:user]
    note_id = params[:note_id]
    @user = User.find_by_username(user_username)
    if !@user.blank?
      @note = Note.find_public_note(@user.id, note_id)
    end
  end

  def new
    @note = Note.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @note = Note.find(params[:id])
    @note.textiled = false
    redirect_to notes_path unless can_access?
  end

  def share
    note = Note.find(params[:id])
    note.private = false
    note.save
    respond_to do |format|
      format.js
    end
  end

  def create
    @note = Note.new(params[:note])
    @note.textiled = false
    @note.tag_list = params[:tags]
    @note.user_id = current_user.id
    respond_to do |format|
      if @note.save
        format.html { redirect_to(notes_url, :notice => 'Anotação criada com sucesso!') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @note = Note.find(params[:id])
    @note.textiled = false
    @note.tag_list = params[:tags]
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(notes_url, :notice => 'Anotação atualizada com sucesso!') }
        format.js
      else
        format.html { render :action => "edit" }
        format.js
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    redirect_to notes_path unless can_access?
    @note.destroy
    respond_to do |format|
      format.html { redirect_to(notes_url) }
    end
  end

  def example
  end

private

  def choose_layout
    if [ 'show'].include? action_name
      'public'
    else
      'application'
    end
  end

end

