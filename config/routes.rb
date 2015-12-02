Rails.application.routes.draw do

  scope :constraints => lambda{ |req| req.session[:user_type] == "admin" } do
    match '/', to: "admin/contest#index", via: :get
  end
  scope :constraints => lambda{ |req| %w(team judge).include? req.session[:user_type] } do
    match '/', to: "problem/problems#index", via: :get
  end

  root "home#index"

  get 'score_board' => 'home#score_board'

  post 'sessions' => 'sessions#create'
  delete 'session' => 'sessions#destroy'

  resources :problems, controller: 'problem/problems'
  resources :submissions, controller: 'problem/submissions', except: :show
  resources :clarifications, controller: 'problem/clarifications', except: [:show]

  namespace :admin do
    resources :users, only: [:index, :create, :destroy]
    get 'contest' => 'contest#index'
    post 'setting' => 'contest#setting'
    post 'contest_start' => 'contest#contest_start'
    post 'contest_stop' => 'contest#contest_stop'
  end

  post 'result_api' => 'api/judge_api#result_api'
end
