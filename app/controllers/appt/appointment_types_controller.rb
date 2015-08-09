require_dependency 'appt/base_controller'

module Appt
  class AppointmentTypesController < BaseController
    before_action :set_appointment_type, only: [:show, :update]

    def index
      @appointment_types = AppointmentType.order(:name).page(params[:page])
    end

    def show
    end

    def update
      @appointment_type.attributes = appointment_type_params

      if @appointment_type.save
        redirect_to appointment_type_path(@appointment_type), notice: 'Your appointment type was saved.'
      else
        render :show
      end
    end

  private

    def appointment_type_params
      params.require(:appointment_type).permit(:name, :duration_minutes, :before_minutes, :after_minutes)
    end

    def set_appointment_type
      @appointment_type = AppointmentType.find(params[:id])
    end
  end
end

