class AvailabilitiesController < ApplicationController
  def new
    @availability = Availability.new
  end
  
  def create
    @availability = Availability.new(availability_params)
    @availability.volunteer_user_id = session[:volunteer_user_id]
    if @availability.save
      flash[:success] = "Availability updated"
      redirect_to current_volunteer_user
    else
      flash.now[:danger] = 'Unsuccessful'
      render 'new'
    end
  end
  
  def show
    @availability = Availability.find(params[:id])
  end
  
  def edit
    @availability = Availability.find_by(volunteer_user_id: params[:id])
  end
  
  def update
    @availability = Availability.find_by(volunteer_user_id: params[:id])
    if @availability.update_attributes(availability_params)
      @availability = availability_params
      redirect_to current_volunteer_user
    else
      render 'edit'
    end
  end
  
  def destroy
    Availability.find(session[:volunteer_user_id]).destroy
  end
  
  private
  
    def availability_params
      params.require(:availability).permit(:mon_st, :mon_en, :tues_st, :tues_en,
      :wed_st, :wed_en, :thur_st, :thur_en, :fri_st, :fri_en, :sat_st, :sat_en,
      :sun_st, :sun_en)
    end
end
