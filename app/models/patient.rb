class Patient < ActiveRecord::Base
  serialize :race
  REGEX = /\A\d{4}+[-]+\d{2}+[-]+\d{2}\z/
  VALID_GENDERS = ['Male', 'Female']
	VALID_RACE = ['Caucasian','Asian','Native Hawaiian Islander', 'Hispanic','Native American/Alaskan','African-American','Unknown']
	VALID_ETHNICITY = ['Hispanic','Non-Hispanic','Unknown']
  
  #validates :medical_record_num, :presence => true,
                                 #:length => { :is => 16 },
                                # :uniqueness => true
                                 
                    
  #validates :en_pid, :presence => true,
                                 #:length => { :is => 24 },
                                 #:uniqueness => true
  
  #validate :check_birth_date
  #validates :birth_date, :presence => true,
                         #:format => { :with => REGEX}
  
  #validate :check_consent_date                       
  #validates :consent_date, :presence => true,
                          # :format => { :with => REGEX}
                           
  #validate :compare_dates
  
  
  #validates :gender, :inclusion => { :in => VALID_GENDERS }
  
  #validates :race, :inclusion => { :in => VALID_RACE }
  
  #validates :ethnicity, :inclusion => { :in => VALID_ETHNICITY}
  
    
  private
  
  def compare_dates
    birth = Date.parse(birth_date) rescue nil
    consent = Date.parse(consent_date) rescue nil
    
    unless birth.nil? || consent.nil?
      if consent < birth
        errors[:base] << "The Consent Date should be greater than Birth Date"
        errors.add(:consent_date)
      end
    end
  end
  
  def check_birth_date
    check_dates(birth_date, "Birth", :birth_date)
  end
  
  
  def check_consent_date
    check_dates(consent_date, "Consent", :consent_date)
  end
  
  def check_dates(args, name, symbol)
    date =  Date.parse(args) rescue nil
    unless date.nil?
      if date > Time.now
        errors[:base] << "The #{name} Date is in future"
        errors.add(symbol)
      end
    end
  end
end
#['Caucasian','Asian','Native Hawaiian Islander','Hispanic','Native 										American/Alaskan','African-American','Unknown']
