Appt::Engine.config.to_prepare do
  if Appt.user_class
    Appt.user_class.class_eval do
    end
  end
end
