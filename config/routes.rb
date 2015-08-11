Appt::Engine.routes.draw do
  resources :calendars do
    resources :appointments
    resources :blocks
  end
  resources :external_calendars, path: 'external-calendars'
  resources :appointment_types, path: 'appointment-types'
  get 'customers/:email', to: 'customers#show', as: :customer
  root to: 'home#index'
end

