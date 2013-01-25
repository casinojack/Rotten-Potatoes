class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # store/retrieve sort order from session
    if params[:sort].blank?
      redirect = true;
      params[:sort] = session[:sort]
    else
      session[:sort] = params[:sort]
    end

    # store/retrieve ratings filter from session
    if params[:ratings].blank?
      redirect = true;
      if session[:ratings].blank?
        session[:ratings] = params[:ratings] = Hash[Movie.ratings.map {|rating| [rating, 1]}]
      else
        params[:ratings] = session[:ratings]
      end
    else
      session[:ratings] = params[:ratings]
    end
    
    # redirect if params blank
    if redirect
      redirect_to movies_path(:sort => params[:sort], :ratings => params[:ratings])
    end

    @all_ratings = Movie.ratings
    @movies = Movie.filter(params[:ratings], params[:sort])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
