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
    end

    def edit
    end

    def update
      @calendar.attributes = calendar_params

      if @calendar.save
        redirect_to calendar_path(@location), notice: 'Your calendar was updated.'
      else
        render :edit
      end
    end

  private

    def calendar_params
      params[:calendar].try(:permit, :name, :availability_text, :timezone_name) || {}
    end

    def set_new_calendar
      @calendar = Calendar.new
    end

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end
  end
end

