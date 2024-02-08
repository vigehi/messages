# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @incoming_messages = Message.where(agent_response: nil).paginate(page: params[:incoming_page], per_page: 10)
    @agent_messages = Message.where.not(agent_response: nil).paginate(page: params[:agent_page], per_page: 10)
  
  

    if params[:search].present?
      search_query = "%#{params[:search]}%"
      @messages = @messages.where("content LIKE :search OR CAST(customer_id AS TEXT) LIKE :search", search: search_query)
    end
  
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
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

  def update
    if @message.update(message_params)
      redirect_to messages_path, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      # Handle successful update
      render json: { message: 'Message successfully updated' }, status: :ok
    else
      # Handle update failure
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
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
