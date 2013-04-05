ThechallengeIo::Application.routes.draw do
  root :to => "entries#index"

  resources :challenges, :path => "challenge"
  resources :entries, :path => "entry"
  resources :users, :path => "user"
  resources :votes, :path => "vote"

  match "submit" => "entries#new", :as => "submit"
  match 'auth/github/callback' => 'sessions#create'
  match "auth/failure" => redirect("/")
  match 'logout' => 'sessions#destroy', :as => "signout"
end