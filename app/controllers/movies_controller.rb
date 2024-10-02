class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  before_action :set_sorting_params, only: %i[ index new create edit update destroy ]

  # GET /movies or /movies.json
  def index
    @movies = Movie.order(Arel.sql("#{@sort_column} #{@sort_direction}"))
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_url(sort: @sort_column, direction: @sort_direction), notice: "Movie was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    if @movie.update(movie_params)
      redirect_to movies_url(sort: @sort_column, direction: @sort_direction), notice: "Movie was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy
    redirect_to movies_url(sort: @sort_column, direction: @sort_direction), notice: "Movie was successfully destroyed."
  end

  private
    def set_sorting_params
      @sort_column = params[:sort] || session[:sort] || "title"
      @sort_direction = params[:direction] || session[:direction] || "asc"

      # Ensure @sort_column is a valid column name to prevent SQL injection
      @sort_column = "title" unless %w[title rating release_date].include?(@sort_column)

      # Ensure @sort_direction is either "asc" or "desc"
      @sort_direction = @sort_direction.downcase == "desc" ? "desc" : "asc"

      session[:sort] = @sort_column
      session[:direction] = @sort_direction
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end
