class Methods

	def crossCheck(uname, pass)
		@flag = User.where(username: uname, password: pass)
	end


end