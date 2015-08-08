Appt::Engine.routes.draw do
  resources :calendars do
    resources :appointments
    resources :blocks
  end
  resources :external_calendars, path: 'external-calendars'
  root to: 'home#index'
end

