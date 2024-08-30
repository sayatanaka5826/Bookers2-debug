class SearchesController < ApplicationController
before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], [:word])
    end
  end

  def index
     @users = User.looks(params[:search], params[:word])
     @books = Book.looks(params[:search], [:word])
  end

end
