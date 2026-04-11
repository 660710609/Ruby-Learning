class Api::V1::PersonController < Api::V1::AppController
  before_action :find_params, only: [ :show, :update, :destroy ]
  skip_before_action :verify_authenticity_token

  def show
    if !@person.nil?
      render json: { success: true, data: @person.name }
    else
      raise JWTError.new("Not Found User")
    end
  end

  def index
    person_all = Person.all
    render json: { success: true, data: person_all }
  end

  def create
    new_person = Person.new(set_params)
    if new_person.save
      render json: { success: true, data: new_person.name }
    else
      render json: { success: false, message: " Invalid name " }
    end
  end

  def update
    @person.update(set_params)
    render json: { success: true, data: @person.name }
  end

  def destroy
    if @person.destroy
      render json: { success: true }
    else
      raise JWTError.new("Invalid person")
    end
  end

  private
  def find_params
    @person = Person.find(params[:id]) rescue nil
  end

  def set_params
    params.require(:person).permit(:name, :age)
    # person: {
    #   name: . . . ,
    #   age : . . .
    # }
  end
end
