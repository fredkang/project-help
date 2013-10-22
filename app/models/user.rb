class User < ActiveRecord::Base

	validates 	:email,	:presence		=> true,
				:email_format 			=> {message: "Invalid email address"},
				:uniqueness				=> {case_sensitive:false, message: "This email already exists"}
	validates	:first_name, :presence		=> true
	validates	:last_name, :presence		=> true
	validates	:password, :presence	=> true,
				:length					=> {in: 6..40}

	before_save{ self.email.downcase! }
	has_secure_password
end
