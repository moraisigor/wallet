Rails.application.routes.draw do
  scope "api" do
    resource :accounts, only: [:create]
    resource :transfers, only: [:create]

    resources :accounts do
      resources :transfers, only: [:index]
    end
  end
end
