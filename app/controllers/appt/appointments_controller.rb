require_dependency 'appt/base_controller'

module Appt
  class AppointmentsController < BaseController
    before_action :set_new_appointment, only: [:new, :create]
    before_action :set_appointment, only: [:show, :edit, :update]

    def new
    end

    def create
      @appointment.attributes = create_params

      if @appointment.save
        redirect_to calendar_path(@calendar), notice: 'Your appointment has been saved.'
      else
        render :new
      end
    end

    def show
    end

  private

    def create_params
      params.require(:appointment).permit(:appointment_type_id, :day, :start, :firstname, :lastname, :email, :phone)
    end

    def set_new_appointment
      @calendar = Calendar.find(params[:calendar_id])
      @appointment = @calendar.appointments.build(params.permit(:appointment_type_id, :day))
    end

    def set_appointment
      @appointment = Appointment.find(params[:id])
      @calendar = @appointment.calendar
    end
  end
end

