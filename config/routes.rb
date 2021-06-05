Rails.application.routes.draw do
  #↓なんで記述してたのか忘れた
  #↓重複してるから消して問題ないはず？
  # get 'users/show'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
end
