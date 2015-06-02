class PracticesController < ApplicationController
  before_action :set_practice, only: [:edit, :update, :destroy, :show]

  def index
    @practices = Practice.order(:name)
  end

  def new
    @practice = Practice.new
  end

  def create
    @practice = Practice.new(practice_params)
    if @practice.save
      redirect_to practices_path, notice: "Practice created"
    else
      render :new, alert: "Please try again"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @practice.update_attributes(practice_params)
      redirect_to practices_path, notice: "Practice updated"
    else
      render :edit, alert: "Please try again"
    end
  end

  def destroy
    @practice.destroy
    redirect_to practices_path, notice: "Practice deleted"
  end

  private
    def practice_params
      params.require(:practice).permit(:name)
    end

    def set_practice
      @practice = Practice.find(params[:id])
    end
end
