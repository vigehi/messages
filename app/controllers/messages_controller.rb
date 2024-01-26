# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
  
    def index
      @messages = Message.all
    end
  
    def new
      @message = Message.new
    end
  
    def create
      @message = Message.new(message_params)
  
      if @message.save
        redirect_to messages_path, notice: 'Message was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def set_message
      @message = Message.find(params[:id])
    end
  
    def message_params
      params.require(:message).permit(:customer_id, :timestamp, :content, :agent_response)
    end
  end
  