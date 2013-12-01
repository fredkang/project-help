class User < ActiveRecord::Base
	has_many :helpoffers, class_name: "Helpoffer", foreign_key: "user_id", dependent: :destroy
	has_many :topics, through: :helpoffers
	has_many :groupusers, dependent: :destroy
	has_many :groups, through: :groupusers
	has_many :posts, as: :postable, dependent: :destroy
	has_many :writeposts, class_name: "Post", foreign_key: "user_id", dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :user1s, class_name: "Conversation", foreign_key: "user1_id", dependent: :destroy
	has_many :user2s, class_name: "Conversation", foreign_key: "user2_id", dependent: :destroy
	has_many :senders, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
	has_many :receivers, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy
	has_many :notifications, class_name: "Notification", foreign_key: "user_id", dependent: :destroy
	has_many :profilenotes, as: :notifiable, class_name: "Notification", foreign_key: "notifiable_id", dependent: :destroy
	has_many :thanks, as: :thanked, class_name: "Thank", foreign_key: "thanked_id", dependent: :destroy
	has_many :thankers, class_name: "Thank", foreign_key: "thanker_id", dependent: :destroy
	has_many :thanked_users, class_name: "Thank", foreign_key: "thanked_uid", dependent: :destroy

	mount_uploader :image, ImageUploader

	accepts_nested_attributes_for :helpoffers, reject_if: proc {|attributes| attributes['title'].blank?},
		:allow_destroy 			=> true
		

	validates 	:email,	:presence				=> true,
				:email_format 					=> {message: "Invalid email address"},
				:uniqueness						=> {case_sensitive:false, message: "This email already exists"}
	validates	:first_name, :presence			=> true
	validates	:last_name, :presence			=> true
	validates	:phone_number, :numericality	=> true,
				:length							=> {is: 10},
				:unless 						=> lambda{ |user| user.phone_number.blank? }
	validates	:password, :presence			=> true,
				:length							=> {in: 6..40},
				:on								=> :create
	validates 	:password, 
				:confirmation 					=> true, 
				:length 						=> { :within => 6..40 }, 
				:on 							=> :update, 
				:unless 						=> lambda{ |user| user.password.blank? }

	before_save{ self.email.downcase! }
	has_secure_password

	# Generates a secure token and saves it in a given column for this user
	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	# Generates data for the password_reset fields, then sends the password reset email to the user
	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent = Time.zone.now
		self.save!

		UserMailer.password_reset(self).deliver
	end

end
