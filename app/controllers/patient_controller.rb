class PatientController < ApplicationController
  def index
    @patient = Patient.all
  end

  def new
    @patient = Patient.new
  end
  
  def show
     @patient = Patient.find(params[:id])
  end
  
  def create
    redirect_to(:action => 'index')
  end

  def update
  end

  def delete
  end
end
