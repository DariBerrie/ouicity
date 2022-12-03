class ChatMessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @chat_message = ChatMessage.new(chat_message_params)
    @chat_message.chatroom = @chatroom
    @chat_message.user = current_user
    if @chat_message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "chatMessage", locals: { message: @chat_message })
      )
      head :ok
    else
      render 'chatrooms/show', status: :unprocessable_entity
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:content)
  end
end
