class ToysController < ApplicationController
    before_action :setup_data

    def index
    end

    def create
        Toy.create(
            name: params[:toy][:name],
            description: params[:toy][:description],
            date: params[:toy][:date],
            user: params[:toy][:user]
        )
            redirect_to(toys_path)
    end

    def new
    end

    def show
        @toy_id = @toys[params[:id].to_i]
        # @toy_id = Toy.find(params[:id])
    end

    def edit
        @toy_id = @toys[params[:id].to_i]
    end

    def update
        @toy_id = @toys[params[:id].to_i]

        Toy.find(@toy_id[:id]).update(
            name: params[:toy][:name],
            description: params[:toy][:description],
            date: params[:toy][:date],
            user: params[:toy][:user]
        )
        redirect_to(toys_path)
    end

    def destroy
        @toy_id = @toys[params[:id].to_i]

        Toy.find(@toy_id[:id]).destroy
        redirect_to(toys_path)
    end

    private
    def setup_data
        @toys = Toy.all
    end
end