class Users::EventsController < ApplicationController
  before_action :set_event, only: [:update]

  def show
    current_user = User.find_by(url: params[:vendor]) if params[:vendor]
    @event = current_user.events.find_by(id: params[:id])
    @featured_events = current_user.events
  end

  def edit
    unless validate_store_admin
      flash[:warning] = "This is not your boat!"
      redirect_to vendor_event_path
    end

    @event = current_user.events.find_by(id: params[:id])
  end

  def update
    @event.update(event_params)
    flash[:success] = "#{@event.name} has been updated."
    redirect_to vendor_event_path
  end

  private

  def event_params
    params.require(:event).permit(:name,
                                  :description,
                                  :price,
                                  :image_url,
                                  :category_id,
                                  :status,
                                  :user_id,
                                  :venue,
                                  :event_date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
