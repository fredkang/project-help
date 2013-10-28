module ApplicationHelper

	# If the time elapsed has been less tha 1 minute, print the time in seconds, if it is less than 1 hour, print the time in minutes, if it is less than 1 day print the time in hours and if it is 1 day or more print the time in days ago
	def format_time_diff(timediff)
		if timediff<60
			if timediff == 1
			 timediffString = "1 second ago"
			else
			 timediffString = timediff.to_s + " seconds ago"
			end
		elsif timediff>=60 && timediff<3600
			if timediff/60 == 1
			 timediffString = "1 minute ago"
			else
			 timediffString = (timediff/60).to_s + " minutes ago"
			end
		elsif timediff>=3600 && timediff<86400
			if timediff/3600 == 1
			 timediffString = "1 hour ago"
			else
			 timediffString = (timediff/3600).to_s + " hours ago"
			end
		else
			if timediff/86400 == 1
			 timediffString = "1 day ago"
			else
			 timediffString = timediff/86400.to_s + " days ago"
			end
		end

		return timediffString
	end

end
