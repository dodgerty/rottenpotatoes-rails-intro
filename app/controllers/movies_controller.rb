class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    #######Part 1############
    
    if params[:sort_by].nil?
      if session[:sort_by].nil?
        
      else
        sort_by = session[:sort_by]
      end
    else
      sort_by = params[:sort_by]
      session[:sort_by] = params[:sort_by]
    end
    
    if sort_by == "title"
      @hilite = "title"
    end
    if sort_by == "release_date"
      @hilite = "release_date"
    end
    
    ######End Part 1##########
    
    ######Part 2##########
   
   @all_ratings = Movie.all_ratings
   
   if params[:ratings].nil?
     if session[:ratings].nil?
       @filtered_ratings = @all_ratings
     else
       @filtered_ratings = session[:ratings].keys
     end
   else
     @filtered_ratings = params[:ratings].keys
     session[:ratings] = params[:ratings]
   end
	 
	 @movies = Movie.order(sort_by).where(rating: @filtered_ratings)
	 
  
    ######End Part 2##########
    
    ########Part 3##############
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
