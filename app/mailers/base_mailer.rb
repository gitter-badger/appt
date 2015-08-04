class BaseMailer < Appt.parent_mailer
  default from: 'from@example.com'
  layout 'mailer'
end

