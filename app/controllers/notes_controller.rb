# coding: utf-8
class NotesController < ApplicationController

  before_filter :authenticate_user!

  def index
    search = params[:search]
    if search.blank?
      @notes = Note.find_my_notes(current_user.id)
    else
      @notes = Note.with_tag(search, current_user.id)
    end
    @tags = Note.find_all_tags(@notes)
    respond_to do |format|
      format.js if request.xhr?
      format.html
    end
  end

  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html
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

end

