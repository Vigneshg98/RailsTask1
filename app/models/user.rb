class User < ApplicationRecord

	validates :username, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, presence:true
	#format: { with: /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x }

	after_save :addFullname

	def addFullname
		User.where(username: self.username, surname: self.surname).update_all(fullname: self.username+" "+self.surname)
	end

end
