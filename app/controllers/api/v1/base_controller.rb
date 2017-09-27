module Api
  module V1
    # Base controller that ensures every controller inheriting from it responds
    # with JSON
    # @author Alain Mauri
    # @version 0.1
    class BaseController < ApplicationController
      respond_to :json
    end
  end
end
