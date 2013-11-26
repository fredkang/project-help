desc "This task resubmits the profile pictures of all users who have a full size picture but no thumbnails"
task :resubmit_pics => :environment do
  puts "Resubmitting pictures"

  User.all.to_a.each do |user|
  	if !user.image_url.nil? && !user.image.thumb.file.exists?
  		# user.image_url = user.image_url
  		user.update_attributes({'remote_image_url'=> user.image_url})
  	end
  end
  
  puts "Done resubmitting pictures"
end

