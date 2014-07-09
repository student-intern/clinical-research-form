class PatientController < ApplicationController
  def index
    @patient = Patient.all
  end

  def new
    @patient = Patient.new
  end
  
  def create
    @patient = Patient.new(argument_list)
    @patient.en_pid = @patient.encrypt_pid
    
    if @patient.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end
  
  def show
     @patient = Patient.find(params[:id])
  end
  
  def update
    @patient = Patient.find(params[:id])
  end
  
  def edit
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(argument_list)
      redirect_to(:action => 'index')
    else
      render('update')
    end
  end

  def delete
    @patient = Patient.find(params[:id])
  end
  
  def destroy
    @patient = Patient.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end
  
  private
  
  def argument_list
    params.require(:patient).permit(:medical_record_num, :birth_date, :gender, {:race => []}, :ethnicity, :consent_date, :created_at)
  end
end
