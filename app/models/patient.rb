class Patient < ActiveRecord::Base
  
  REGEX = /\A\d{4}+[-]+\d{2}+[-]+\d{2}\z/
  VALID_GENDERS = ['Male', 'Female']
	VALID_RACE = ['Caucasian','Asian','Native Hawaiian Islander','Hispanic','Native American/Alaskan','African-American','Unknown']
	VALID_ETHNICITY = ['Hispanic','Non-Hispanic','Unknown']
  
  validates :medical_record_num, :presence => true,
                                 :length => { :maximum => 16 },
                                 :uniqueness => true
                                 
                    
  validates :en_pid, :presence => true,
                                 :length => { :maximum => 16 },
                                 :uniqueness => true

  
  validate :must_match_gender
  
  validate :must_match_race
  
  validate :must_match_ethnicity
  
  validate :check_for_future
  
  validate :check_consent_date
    
  private
  
  def check_for_future
    if birth_date.blank?
      errors[:base] << "The Birth Date field is blank"
    else
      if !REGEX.match(birth_date) || !REGEX.match(consent_date)
        errors[:base] << "The Birth Date is in wrong format"
      else
        if Date.parse(birth_date) > Time.now
          errors[:base] << "The Birth Date is in future"
        end
      end
    end
  end
  
  def must_match_gender
    if VALID_GENDERS.exclude?(gender)
      errors[:base] << "The choice of gender does not match!"
    end
  end

  def must_match_race
    if VALID_RACE.exclude?(race)
      errors[:base] << "The choice of race does not match!"
    end
  end

  def must_match_ethnicity
    if VALID_ETHNICITY.exclude?(ethnicity)
      errors[:base] << "The choice of ethnicity does not match!"
    end
  end
  
  def check_consent_date
    if consent_date.blank?
      errors[:base] << "The Consent Date field is blank"
    else
      if !REGEX.match(consent_date) || !REGEX.match(birth_date)
        errors[:base] << "The Consent Date or Birth Date is in wrong format"
      else
        if Date.parse(consent_date) > Time.now
          errors[:base] << "The Consent Date is in future"
        end
        if Date.parse(consent_date) < Date.parse(birth_date)
          errors[:base] << "The Consent Date must be greater than Birth Date"
        end
      end
    end
  end
end
