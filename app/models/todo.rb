class Todo < ActiveRecord::Base
  
  attr_accessible :title, :details
  
  # Validations

  #validates :title, :presence=>true

  #validates :details, :presence=>true
  
  # Validation Examples
  #LANDLINE_LIST = ["1234567890", "0987654321"]
  #validates :first_name, 
  #           :presence=>true,
  #           :length => {:minimum => ConfigCenter::GeneralValidations::FIRST_NAME_MIN_LEN ,
  #           :maximum => ConfigCenter::GeneralValidations::FIRST_NAME_MAX_LEN, :message => "should be less than x and greater than y"}, 
  #           :uniqueness => {:scope => [:user_id, :status], :case_sensitive => false},
  #           :format => {:with => ConfigCenter::GeneralValidations::FIRST_NAME_FORMAT_REG_EXP, :message => "Invalid format"},
  #           :inclusion => { :in => PHONE_LIST, :message => "not included in the list" },
  #           :unless => proc{|user| user.password.blank? }
  
end
