class Helpoffer < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => true

  validates :title, :presence	=> true

end
