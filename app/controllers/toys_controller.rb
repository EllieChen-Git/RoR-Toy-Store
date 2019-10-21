class ToysController < ApplicationController
    before_action :setup_data
    before_action :set_toy, only: [:show, :edit, :update, :destroy]

    def index
    end

    def new
        @toy = Toy.new
    end
    
    def create
        Toy.create(
            name: params[:toy][:name],
            description: params[:toy][:description],
            date: params[:toy][:date],
            user: User.find(params[:toy][:user].to_i)
        )
            redirect_to(toys_path)
    end



    def show

    end

    def edit

    end

    def update
        Toy.find(@toy[:id]).update(
            name: params[:toy][:name],
            description: params[:toy][:description],
            date: params[:toy][:date],
            user: User.find(params[:toy][:user].to_i)
        )
        redirect_to(toys_path)
    end

    def destroy
        Toy.find(@toy[:id]).destroy
        redirect_to(toys_path)
    end

    private
    def setup_data
        @toys = Toy.all
        @users = User.all
    end

    def set_toy
        @toy = Toy.find(params[:id])
    end
end