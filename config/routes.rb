ThechallengeIo::Application.routes.draw do
  root :to => "entries#index"

  resources :challenges
  resources :entries
  resources :users

  match 'auth/github/callback' => 'sessions#create'
  match "auth/failure" => redirect("/")
  match 'logout' => 'sessions#destroy', :as => "signout"
end