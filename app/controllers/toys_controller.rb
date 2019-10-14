class ToysController < ApplicationController
    before_action :setup_data

    def index

    end

    # def show
    #     @toy_id = @toys(params[:id])
    # end

    private
    def setup_data
        @toys = Toy.all
    end
end