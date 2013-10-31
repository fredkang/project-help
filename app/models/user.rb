class User < ActiveRecord::Base
	has_many :helpoffers, class_name: "Helpoffer", foreign_key: "user_id", dependent: :destroy
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
	has_many :profilenotes, class_name: "Notification", foreign_key: "notifiable_id", dependent: :destroy

	accepts_nested_attributes_for :helpoffers, 
		:allow_destroy 			=> true
		# :reject_if 				=> :all_blank #lambda {|attributes| attributes['title'].blank? || attributes['description'].blank?}

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

end
