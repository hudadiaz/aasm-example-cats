class CatsController < ApplicationController
  before_action :set_cat, only: [:show, :edit, :update, :destroy]

  def index
    @cats = Cat.all
  end

  def show
  end

  def new
    @cat = Cat.new
  end

  def edit
  end

  def create
    @cat = Cat.new(cat_params)

    respond_to do |format|
      if @cat.save
        format.html { redirect_to @cat, notice: "#{@cat.name} was successfully created." }
        format.json { render :show, status: :created, location: @cat }
      else
        format.html { render :new }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cat.assign_attributes(cat_params) 
    respond_to do |format|
      if @cat.public_send("#{event}!")
        format.html { redirect_to @cat, notice: "#{@cat.name} is #{@cat.aasm_state}!" }
        format.json { render :show, status: :ok, location: @cat }
      end
    end
  rescue AASM::InvalidTransition
    respond_to do |format|
      format.html { redirect_to @cat, error: "#{@cat.name} cannot #{event}." }
      format.json { render json: @cat.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    name = @cat.name
    @cat.destroy
    respond_to do |format|
      format.html { redirect_to cats_url, warning: "#{name} has been slained." }
      format.json { head :no_content }
    end
  end

  private
    def set_cat
      @cat = Cat.find(params[:id])
    end

    def cat_params
      params.require(:cat).permit(:name, :aasm_state, :stamina)
    end

    def event
      params.require(:cat).fetch(:event, 'save')
    end
end
