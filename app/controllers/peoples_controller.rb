class PeoplesController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, only: [:custom_destroy]
  before_action :set_person, only: [:show, :edit, :update, :custom_destroy]

  def new
   @person = Person.new
   @person.build_detail
  end

  def index
    @people = Person.includes(:detail)

    respond_to do |format|
      format.html { render 'index' } # Render HTML view
      format.json { render json: @people, include: :detail } # Render JSON for API
    end
  end

  def show
    respond_to do |format|
      format.html { render 'show' } # Render HTML view
      format.json { render json: @person, include: :detail } # Render JSON for API
    end
  end

  def create
    person = Person.new(person_params)
    detail = Detail.new(detail_params)

    if person.save
      detail.person = person
      if detail.save
        respond_to do |format|
          format.html { redirect_to people_path, notice: 'Person and detail were successfully created.' }
          format.json { render json: { person: person, detail: detail }, status: :created }
        end
      else
        respond_to do |format|
          format.html { render 'new' } # Render HTML view for error
          format.json { render json: { errors: detail.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render 'new' } # Render HTML view for error
        format.json { render json: { errors: person.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit
   @person.build_detail unless @person.detail.present?
  end

  def update
  if @person.update(person_params) && @person.detail.update(detail_params)
    respond_to do |format|
      format.html { redirect_to people_path, notice: 'Person and detail were successfully updated.' }
      format.json { render json: { person: @person, detail: @person.detail }, status: :ok }
    end
  else
    respond_to do |format|
      format.html { render 'edit' } # Render HTML view for error
      format.json { render json: { errors: @person.errors.full_messages + @person.detail.errors.full_messages }, status: :unprocessable_entity }
    end
  end
end

  def custom_destroy
    if @person.destroy
      respond_to do |format|
        format.html { redirect_to people_path, notice: 'Person and detail were successfully destroyed.' }
        format.json { render json: { message: 'Person and detail were successfully destroyed.' }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to people_path, alert: 'Failed to destroy person and detail.' }
        format.json { render json: { errors: @person.errors.full_messages + @person.detail.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, detail_attributes: [:email, :title, :age, :phone])
  end

  def detail_params
  params.require(:person).require(:detail_attributes).permit(:email, :title, :age, :phone)
  end
end
