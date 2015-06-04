Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'todays_token', to: 'patients#todays_token'
  resources :patient_answers, only: [:show, :new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :patients, only: [:new, :index, :create, :update, :show] 
  resources :users, expect: :show
  resources :practices
  resources :bodyparts
  resources :presentations
  resources :survey_questions
  resources :translates
  resources :password_resets, only: [:new, :create, :edit, :update]
  root to: 'users#index'
end
