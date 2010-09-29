# coding: utf-8
class NotesController < ApplicationController
  
  def index
    @notes = Note.all

    respond_to do |format|
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
    @note.text = @note.text_source

  end

  def create
    @note = Note.new(params[:note])
    @note.tag_list = params[:tags]
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

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(notes_url, :notice => 'Anotação atualizada com sucesso!') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
    end
  end
end
