class ToysController < ApplicationController
    before_action :setup_data

    def index
    end

    def create
        Toy.create(
            name: params[:toy]["name"],
            description: params[:toy]["description"],
            date: params[:toy]["date"],
            user: params[:toy]["user"]
        )
            redirect_to(toys_path)
    end

    def new
    end

    def show
        @toy_id = @toys[params[:id].to_i]
    end

    # def edit

    # end

    # def update

    # end

    private
    def setup_data
        @toys = Toy.all
    end
end