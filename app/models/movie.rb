class Movie < ActiveRecord::Base
    
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    
    def self.all_ratings
        return @all_ratings
    end
    
    # def self.with_ratings(ratings)
    #      return Movie.where(rating: ratings)
    # end
    
end
