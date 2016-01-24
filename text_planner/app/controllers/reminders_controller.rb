class RemindersController < ApplicationController
  
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find_by_id params[:user_id]
    @reminders = @user.reminders
    if @reminders.length == 0
      flash[:notice] = 'You have no reminders scheduled. Create one now to get started.'
    end
  end

  def new
  end

  def create
    @reminder = Reminder.new(params[:reminder])
    @reminder.user_id = current_user.id
    # if saved
    respond_to do |format|
      if @reminder.save
        flash[:success] = 'Reminder was created successfully!'
        format.html {
          redirect_to user_reminders_path(current_user.id)
        }
      else
        flash[:notice] = 'Reminder could not be created. Please try again.'
        format.html {
          redirect_to new_user_reminders_path
        }
        format.json {
          render json: @reminder.errors.full_messages
        }
    # else
      end
    end
  end

  def show
    @reminder
  end

  def edit
    @reminder 
  end

  def update
    # @reminder.user_id = current_user.id

    respond_to do |format|
      if @reminder.update_attributes(reminder_params)
        flash[:success] = 'Reminder has been successfully updated.'
        format.html {
          redirect_to user_reminders_path(current_user.id)
        }
        format.json {
          render json: @reminder
        }
      else
        flash[:error] = 'Reminder could not be updated.'
        format.html {
          redirect_to edit_bookmarks_path
        }
        format.json {
          render json: @reminder.errors.full_messages
        }
      end
    end
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
