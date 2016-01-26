class RemindersController < ApplicationController
  
  def index
    @user = User.find_by_id params[:user_id]
    @reminders = @user.reminders
    if @reminders.length == 0
      flash[:notice] = 'You have no reminders scheduled. Create one now to get started.'
    end
  end

  def new
    @user = User.find_by_id params[:user_id]
    @reminder = @user.reminders.build
  end

  def create
    @reminder = current_user.reminders.build reminder_params

    respond_to do |format|
      if @reminder.save
        # set variables that will be in the twilio txt message
        flash[:success] = 'Reminder was created successfully!'
        format.html {
          redirect_to user_reminders_path(@user)
        }
      else
        flash.now[:notice] = 'Reminder could not be created. Please try again.'
        format.html {
          render :new
        }
        format.json {
          render json: @reminder.errors.full_messages
        }
      end
    end
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def edit
    @reminder = Reminder.find(params[:id])
  end

  def update
   @reminder = Reminder.find(params[:id])
   @reminder.user_id = current_user.id

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
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to user_reminders_path(current_user.id), notice: 'reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:title, :time)
  end
end
