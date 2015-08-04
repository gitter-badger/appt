Appt::Engine.routes.draw do
  resources :calendars do
    resources :appointments
    resources :blocks
  end
  root to: 'home#index'
end

