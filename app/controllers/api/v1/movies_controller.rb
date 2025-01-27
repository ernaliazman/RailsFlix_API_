module Api
    module V1
        class MoviesController < ApplicationController
            # Verify the authentication token
            before_action :authorize_request
            def index
                @movies = Movies.all
                render json: {
                    status: :Fetched,
                    results: @movies
                }
            end

#define user_id as id when passing data in the endpoints
            def show
                @movies = Movies.where(user_id: params[:id])
                if @movies.any?
                    render json: {
                      status: :Fetched,
                      results: @movies
                    }
                else
                    render json: {
                      status: :Fetched,
                      results: [] # Return an empty array instead of a 404 error
                    }, status: :ok
                end
            end

            def create
                @movie = Movies.new(movie_params)
                if @movie.save
                    render json: {
                        status: :Created,
                        results: @movie
                    }

                else
                render json: {
                    status: :unprocessable_entity,
                    errors: @movie.errors }, status: :unprocessable_entity

                end
            end

            def update
                @movie = Movies.find_by(id: params[:id])
                if @movie.update(update_params)
                    render json: {
                        status: :Updated,
                        results: @movie
                    }
                else
                    render json: @movie.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @movie = Movies.find_by(id: params[:id])

                if @movie.present?
                    @movie.destroy
                    render json: {
                        status: :Deleted,
                        results: @movie
                    }
                else
                    render json: {
                        status: :NotFound,
                        error: "Movie not found"
                    }
                end
            end

            private
            def movie_params
                params.require(:movie).permit(:id, :title, :casts, :directors, :genres, :status, :released_date, :score, :poster_path, :user_id)
            end

            # def movie_user_params
            #     params.require(:movie).permit(:id,:title, :casts, :directors, :genres, :status, :released_date, :score, :poster_path, :userId)
            # end

            def update_params
                params.require(:movie).permit(:status, :review)
            end


          # def delete
          #     @movie = Movies.find(params[:id])
          #     @movie.destroy
          #     render json: @movie
          # end
        end
    end
end
