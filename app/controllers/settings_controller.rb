class SettingsController < ApplicationController

  def edit
    @settings = current_user.settings
  end

  def update
    current_user.settings = params[:settings]
    current_user.save
    redirect_to root_path, notice: "Settings saved"
  end
end
