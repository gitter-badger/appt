Appt::Engine.routes.draw do
  resources :calendars do
    resources :appointments
    resources :blocks
  end
  resources :external_calendars, path: 'external-calendars'
  resources :appointment_types, path: 'appointment-types'
  root to: 'home#index'
end

