Snote::Application.routes.draw do
  devise_for :users

  root :to => "notes#index"
  resources :notes
  match 'notes/example' => "notes#example"
  match 'notes/search' => "notes#search"
  match 'notes/share/:id' => "notes#share", :as => 'note_share'
  match "public/notes/:user/:note_id" => "notes#show", :as => 'post_note'

end

