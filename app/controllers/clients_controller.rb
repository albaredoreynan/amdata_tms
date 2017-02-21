class ClientsController < ApplicationController
	before_filter :set_client, only: [:show, :update, :destroy, :edit]

  def index
    @clients = Client.all
    # split_space(params["q"]) if params["q"].present?
    # @q = Client.ransack(params[:q])
    # @clients = @q.result.includes(:employer).paginate(:page => (params[:page]), :per_page => 10)
  end

  def split_space(contents)
    contents.values.each { |c| c.strip! if c.present? }
  end

  def create
    @client = Client.new(client_params)
    
    if @client.save
      # render json: @client, status: :created, client: [:api, @client]
      redirect_to api_clients_path, notice: 'Entry created'
    else
      flash[:alert] = @client.errors.full_messages.first
      render action: "new", id: @client.id
      # redirect_to new_api_client_path, alert: @client.errors.full_messages.to_sentence
      # render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      redirect_to api_clients_path, notice: 'Entry updated'
    else
      flash[:alert] = @client.errors.full_messages.first
      render action: "new", id: @client.id
      # redirect_to edit_api_client_path, alert: @client.errors.full_messages.to_sentence
      # render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  def new
    @client = Client.new
  end
  
  def destroy
    @client.destroy
    redirect_to api_clients_path, notice: 'Entry successfully deleted'
  end

  private 
  def set_client
    @client = Client.find(params[:id])
  end
    
  def client_params
    split_space(params[:client])
    params.require(:client).permit(:name, :address, :contact_person, :contact_info)
  end
end