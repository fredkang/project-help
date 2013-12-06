module PostpartialsHelper

	# Given an array of thanks for a post or a comment, produces the appropriate string
	# that describes who thanked the user for the post or comment
	def thanks_string(thanks)
		thanksString = "";

		if thanks.length > 4 
			thanks.each_with_index do |thank, index| 
				thank_user = User.find(thank.thanker_id) 

				if index <= 3 
					thanksString += "<a href='/users/" + thank_user.id.to_s+"'>"+thank_user.first_name + "</a>, " 

				else 
					thanksString += "and " + (thanks.length-3).to_s + " others found this helpful"
					break 
				end 
			end 

		elsif thanks.length == 1 
			thank = thanks[0] 
			thank_user = User.find(thank.thanker_id) 

			thanksString += "<a href='/users/" + thank_user.id.to_s+"'>"+thank_user.first_name + "</a> found this helpful" 

		elsif thanks.length == 2 
			thanks.each_with_index do |thank, index| 
				thank_user = User.find(thank.thanker_id)

				if index == 0 
					thanksString += "<a href='/users/" + thank_user.id.to_s+"'>" + thank_user.first_name + "</a>"
				else 
					thanksString += " and <a href='/users/" + thank_user.id.to_s+"'>" + thank_user.first_name + "</a> found this helpful"
				end 
			end 

		elsif thanks.length > 2 
			thanks.each_with_index do |thank, index| 
				thank_user = User.find(thank.thanker_id) 
				
				if index != thanks.length-1 
					thanksString += "<a href='/users/" + thank_user.id.to_s+"'>" + thank_user.first_name + "</a>, " 

				else 
					thanksString += "and " + (thanks.length-3).to_s + " others found this helpful" 
				end 
			end 
		end 

		return thanksString
	end

end