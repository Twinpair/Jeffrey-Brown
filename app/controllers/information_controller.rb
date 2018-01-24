class InformationController < ApplicationController
  def index
    @information = Information.first
  end

  def edit
    @information = Information.first
  end

  def update
    @information = Information.find(params[:id])
    @information.update(information_params)
    redirect_to information_index_path
  end

private

  def information_params
    params.require(:information).permit(:name, :about, :services_description, :photography_description, :contact_description, :header_image, :email, :phone)
  end

end
