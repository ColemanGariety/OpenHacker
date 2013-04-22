ThechallengeIo::Application.routes.draw do
  root :to => "entries#index"


  resources :challenges
  resources :entries
  resources :users
  resources :votes

  get 'suggestions' => 'challenges#suggestions', :as => 'challenge_suggestions'

  match 'top' => 'entries#top', :as => 'top'
  match 'submit' => "entries#new", :as => 'submit'
  match 'auth/github/callback' => 'sessions#create'
  match "auth/github/update" => "sessions#update"
  match 'auth/failure' => redirect("/")
  match 'logout' => 'sessions#destroy', :as => 'signout'
  match 'about' => 'challenges#about'
  match 'rules' => 'challenges#rules'

  put 'users/:username/ban' => 'users#ban', :as => "ban"
  put "vote", :to => "votes#vote", :as => :vote
end