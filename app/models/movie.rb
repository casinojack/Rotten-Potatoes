class Movie < ActiveRecord::Base

  def self.ratings
    return ['G','PG','PG-13','R']
  end

  def self.filter(ratings, order)
    #puts "Rating: " + filters.to_s
    #self.where(:rating => filters[0]).order(order)
    self.all(:order => order, :conditions => ["rating IN (?)", ratings.keys])
  end
end
