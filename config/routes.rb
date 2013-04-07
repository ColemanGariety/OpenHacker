ThechallengeIo::Application.routes.draw do
  root :to => "entries#index"

  resources :challenges
  resources :entries
  resources :users
  resources :votes

  get "suggestions" => "challenges#suggestions", :as => "challenge_suggestions"

  match "submit" => "entries#new", :as => "submit"
  match 'auth/github/callback' => 'sessions#create'
  match "auth/failure" => redirect("/")
  match 'logout' => 'sessions#destroy', :as => "signout"

end