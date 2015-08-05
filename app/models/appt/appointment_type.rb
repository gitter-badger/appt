module Appt
  class AppointmentType < ActiveRecord::Base
    has_many :appointments, dependent: :destroy
  end
end

