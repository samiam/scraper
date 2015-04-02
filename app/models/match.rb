class Match < ActiveRecord::Base
  validates :visitor, :home, :date, :visitor_points, :home_points,
            presence: true
  validates :visitor_points, :home_points,
            numericality: {only_integer: true, greater_than_or_equal_to: 0}
  
  def score
    self.visitor_points.to_s + " - " + self.home_points.to_s
  end

  def event_time
    self.date.strftime("%Y-%m-%d")
  end
end
