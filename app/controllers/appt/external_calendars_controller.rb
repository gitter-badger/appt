require_dependency 'appt/base_controller'

module Appt
  class ExternalCalendarsController < BaseController
    before_action :set_external_calendar, only: [:show, :edit, :update]

    def new
      @external_calendar = ExternalCalendar.new
    end

    def create
      @external_calendar = ExternalCalendar.new(create_params)
      @external_calendar.sync_metadata
      if @external_calendar.save
        redirect_to external_calendar_path(@external_calendar), notice: 'Your external calendar was created.'
      else
        render :new
      end
    end

    def show
      @calendars = @external_calendar.calendars.order(:name).page(params[:calendars_page])
      @blocks = @external_calendar.blocks.includes(:calendar).order(:day, :start, :end).page(params[:blocks_page])
    end

    def edit
    end

    def update
      method = params[:method]
      notice = 'Your external calendar was updated.'

      case method
      when 'sync'
        @target_calendar = Calendar.find_by_id(params[:external_calendar_sync][:calendar_id])

        if @target_calendar
          @external_calendar.sync @target_calendar
          notice = "Your external calendar's blocks were refreshed."
        else
          flash.alert = 'You must select a target calendar.'
        end
      when 'sync_metadata'
        @external_calendar.sync_metadata
        notice = "Your external calendar's metadata was refreshed."
      else
        @external_calendar = update_params
      end

      if @external_calendar.save
        redirect_to external_calendar_path(@external_calendar), notice: notice
      else
        render :show
      end
    end

    def index
      @external_calendars = ExternalCalendar.order(name: :asc).page(params[:page])
    end

  private

    def set_external_calendar
      @external_calendar = ExternalCalendar.find(params[:id])
    end

    def create_params
      params.require(:external_calendar).permit(:url, :name)
    end
  end
end

