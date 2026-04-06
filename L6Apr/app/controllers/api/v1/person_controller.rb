class Api::V1::PersonController < ApplicationController
  before_action :find_params, only: [ :show, :update, :destroy ]

def show
  @person = Person.find(params[:id])

  render json: @person.as_json(
    only: [ :id, :name ],
    include: {
      assignments: {
        only: [ :role ],
        include: {
          project: { only: [ :title ] }
        }
      }
    }
  )
end

  def index
    all_person = Person.all
    render json: all_person.as_json(only: [ :id, :name ])
  end

  def create
    new_person = Person.new(params_update_create)
    if new_person.save
      render json: new_person.as_json(only: [ :id, :name ])
    else
      render json: { status: 400, error: person.errors.as_json }, status: 400
    end
  end

  def update
    @person.update(params_update_create)
    render json: @person.as_json(only: [ :id, :name ], include: { phone_number: { only: [ :number ] } })
  end

  def destroy
    if @person.destroy
      render json: { Message: "Success" }
    else
      render json: { status: 400, error: person.errors.as_json }, status: 400

    end
  end

  private
  def find_params
    @person = Person.find(params[:id])
  end

  def params_update_create
    params.require(:person).permit(:name)
  end
end
