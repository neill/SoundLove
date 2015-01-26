class SoundsController < ApplicationController
    before_action :authenticate_user!, only: [:index]
    def show
    end

    def index
        @user = current_user
    end
end
