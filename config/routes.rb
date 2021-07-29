Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    # resources only: [:index]
    resources :merchants
    resources :invoices
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]

end
