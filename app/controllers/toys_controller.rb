class ToysController < ApplicationController
    before_action :setup_data
    before_action :set_toy, only: [:show, :edit, :destroy] #:update

    def index
    end

    def new
        @toy = Toy.new
    end
    
    def create
        whitelisted_params = params.require(:toy).permit(:name, :description, :date, :user_id, :pic)
        @toy = Toy.create(whitelisted_params)
        if @toy.errors.any?
            render "new"
        else
            redirect_to toys_path
        end
    end

    def show
    end

    def edit
    end

    def update
        whitelisted_params = params.require(:toy).permit(:name, :description, :date, :user_id, :pic)
        @toy = Toy.find(params[:id]).update(whitelisted_params)
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