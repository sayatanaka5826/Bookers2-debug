class ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]

  def show
    @chats = Chat.all
    @chat = current_user.chats.new(chat_params)
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
    end
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validate unless @chat.save
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end


  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to  books_path
    end
  end


end
