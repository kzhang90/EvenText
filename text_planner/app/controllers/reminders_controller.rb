class RemindersController < ApplicationController
  
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]

  def index
    @reminders = current_user.reminders
    @reminder = Reminder.new
    @user = User.find_by_id params[:user_id]
    if @reminders.length == 0
      flash[:notice] = "You have no reminders scheduled. Create one now to get started."
    end
  end

  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to reminders_url, notice: 'reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_reminder
    @reminder = Reminder.find(params[:id])
  end
end
