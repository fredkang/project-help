class User < ActiveRecord::Base
	has_many :helpoffers, class_name: "Helpoffer", foreign_key: "user_id", dependent: :destroy
	has_many :groupadmins, dependent: :destroy
	has_many :groupusers, dependent: :destroy
	has_many :groups, through: :groupusers

	accepts_nested_attributes_for :helpoffers, 
		:allow_destroy 			=> true
		# :reject_if 				=> :all_blank #lambda {|attributes| attributes['title'].blank? || attributes['description'].blank?}

	validates 	:email,	:presence			=> true,
				:email_format 				=> {message: "Invalid email address"},
				:uniqueness					=> {case_sensitive:false, message: "This email already exists"}
	validates	:first_name, :presence		=> true
	validates	:last_name, :presence		=> true
	validates	:phone_number, :presence	=> true
	validates	:password, :presence		=> true,
				:length						=> {in: 6..40},
				:on							=> :create
	validates 	:password, 
				:confirmation 				=> true, 
				:length 					=> { :within => 6..40 }, 
				:on 						=> :update, 
				:unless 					=> lambda{ |user| user.password.blank? }

	before_save{ self.email.downcase! }
	has_secure_password

end
