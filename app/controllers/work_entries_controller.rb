class WorkEntriesController < ApplicationController
	
	before_filter :set_work_entry, only: [:show, :update, :destroy]

  def index
    @work_entries = WorkEntry.paginate(:page => params[:page], :per_page => 20)
    # render json: @work_entries
  end

  def new
    @work_entry = WorkEntry.new
    @clients = Client.all
  end
  
  def edit
    @work_entry = WorkEntry.find(params[:id])
  end

  def show
    @work_entry = WorkEntry.find(params[:id])
    @carl_fields = CarlField.where(work_entry_id: @work_entry.id)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "Reimbursement Form",
              :orientation  => 'Portrait',
              :page_width   => '13in',
              :margin => {:top       => 1,
                           :bottom   => 1}
      end
    end
  end

  def create
    @work_entry = WorkEntry.new(work_entry_params)

    if @work_entry.save
      flash[:success] = 'Case Reference was successfully created.'
      redirect_to work_entries_path
    else
      flash[:error] = 'An error occured while creating new work_entry.'
      render 'new'
    end
  end

  def update
    if @work_entry.update(work_entry_params)
      flash[:success] = 'Case Reference was successfully updated.'
      redirect_to work_entries_path
    else
      flash[:error] = 'An error occured while creating new work_entry.'
      render 'new'
    end
  end
  
  def destroy
    @work_entry.destroy!
    flash[:success] = 'Case Reference has been deleted.' 
    redirect_to work_entries_path
  end

  private

    def set_work_entry
      @work_entry = WorkEntry.find(params[:id])
    end
      
    def work_entry_params
      params.require(:work_entry).permit(:entry_date, :client_id, :time_in, :time_out, :details, :user_id)
    end
end
