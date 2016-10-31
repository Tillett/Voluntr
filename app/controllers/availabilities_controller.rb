class AvailabilitiesController < ApplicationController
  def new
    @availability = Availability.new
  end
  
  def create
    Availability.where(volunteer_user_id: session[:volunteer_user_id]).delete_all
    @availability = Availability.new(availability_params)
    @availability.volunteer_user_id = session[:volunteer_user_id]
    if @availability.save
      flash[:success] = "Availability updated"
      redirect_to @availability
    else
      flash.now[:danger] = 'Unsuccessful'
      render 'new'
    end
  end
  
  def show
    @availability = Availability.find(params[:id])
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
