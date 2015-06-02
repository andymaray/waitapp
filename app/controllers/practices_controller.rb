class PracticesController < ApplicationController

  def index
    @practices = Practice.order(:name)
  end

  def new
    @practice = Practice.new
  end

  def create
    @practice = Practice.new(practice_params)
    if @practice.save
      redirect_to root_url, notice: "Practice created"
    else
      render :new, alert: "Please try again"
    end
  end

  def show
    @practice = Practice.find(params[:id])
  end

  def edit
    @practice = Practice.find(params[:id])
  end

  def update
    @practice = Practice.find(params[:id])
    if @practice.update_attributes(practice_params)
      redirect_to @practice, notice: "Practice updated"
    else
      render :edit, alert: "Please try again"
    end
  end

  def destroy
    @practice.destroy
    redirect_to root_url, notice: "Practice deleted"
  end

  private
    def practice_params
      params.require(:practice).permit(:name)
    end

    def set_presentation
      @practice = Practice.find(params[:id])
    end
end
