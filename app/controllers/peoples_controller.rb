class PeoplesController < ApplicationController
  before_action :set_person, only: [:show]

  def index
    render json: Person.includes(:detail)
  end

  def show
    render json: @person, include: :detail
  end

  def create
    person = Person.new(person_params)
    detail = Detail.new(detail_params)

    if person.save
      detail.person = person
      if detail.save
        render json: { person: person, detail: detail }, status: :created
      else
        render json: { errors: detail.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: person.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name)
  end

  def detail_params
    params.require(:detail).permit(:email, :title, :age, :phone)
  end
end
