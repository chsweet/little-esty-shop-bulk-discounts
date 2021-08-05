Rails.application.routes.draw do
  root 'welcome#index'

  namespace :admin do
    resources :merchants
    resources :invoices
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]

  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :items
    resources :bulk_discounts
    resources :invoices, only: [:index, :show]
    resources :invoice_item, only: [:update]
  end
end
