require_dependency 'appt/base_controller'

module Appt
  class CalendarsController < BaseController
    before_action :set_new_calendar, only: [:new, :create]
    before_action :set_calendar, only: [:show, :edit, :update]

    def index
      @calendars = Calendar.order(name: :asc).page(params[:page])
    end

    def new
    end

    def create
      @calendar.attributes = calendar_params

      if @calendar.save
        redirect_to calendar_path(@calendar), notice: 'Your calendar was created.'
      else
        render :new
      end
    end

    def show
      @start_date = params[:start_date] ? Date.parse(params[:start_date]) : @calendar.today
      @start_date = @start_date.at_beginning_of_month

      @appointments = @calendar.appointments.where('day >= ? and day <= ?', @start_date, @start_date.at_end_of_month)
      @blocks = @calendar.blocks.where('day >= ? and day <= ?', @start_date, @start_date.at_end_of_month)
    end

    def edit
    end

    def update
      @calendar.attributes = calendar_params

      if @calendar.save
        redirect_to calendar_path(@calendar), notice: 'Your calendar was updated.'
      else
        render :edit
      end
    end

  private

    def calendar_params
      params[:calendar].try(:permit, :name, :availability_text, :timezone_name, appointment_type_ids: []) || {}
    end

    def set_new_calendar
      @calendar = Calendar.new
    end

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end
  end
end

