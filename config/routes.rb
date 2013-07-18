ThechallengeIo::Application.routes.draw do
  root :to => "entries#index"

  resources :challenges
  resources :entries
  resources :users
  resources :votes

  get 'suggestions' => 'challenges#suggestions', :as => 'challenge_suggestions'

  get 'top' => 'entries#top', :as => 'top'
  get 'submit' => "entries#new", :as => 'submit'
  get 'auth/github/callback' => 'sessions#create'
  get "auth/github", :as => "auth"
  get "auth/github/update" => "sessions#update"
  get 'auth/failure' => redirect("/")
  get 'logout' => 'sessions#destroy', :as => 'signout'
  get 'about' => 'challenges#about'
  get 'rules' => 'challenges#rules'
  get 'entries/:id/track' => 'entries#track'
  
  get 'get_screen' => "entries#get_screen"

  put 'users/:username/ban' => 'users#ban', :as => "ban"
  put "vote", :to => "votes#vote", :as => :cast
end