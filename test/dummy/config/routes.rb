Rails.application.routes.draw do
  mount Appt::Engine => '/appt'

  root to: redirect('/appt')
end

