Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    delete '/users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  scope 'nnect' do
    resources :events, only: %i(index new show edit create update)

    get '/edit', to: 'users#edit', as: :edit_user
    patch '/' => 'users#update'
    delete '/' => 'users#destroy'
    # editより必ずあとに持ってくる（editがnicknameとして扱われるため）
    resources :users, path: '', only: [:index, :show], param: :nickname
  end

  resources :interests, path: "tags" , only: [:new, :create, :index, :edit, :update, :destroy]

  root 'top#index'
end
