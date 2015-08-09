require_dependency 'appt/base_controller'

module Appt
  class BlocksController < BaseController
    before_action :set_block

    def show
    end

  private

    def set_block
      @block = Block.find(params[:id])
      @calendar = @block.calendar
    end
  end
end

