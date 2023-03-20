module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: %i[show update destroy]
      skip_before_action :authenticate_request, only: %i[get show]

      # GET /api/v1/tags
      def index
        @tags = Tag.all

        render json: @tags
      end

      # GET /api/v1/tags/1
      def show
        render json: @tag
      end

      # POST /api/v1/tags
      def create
        @tag = Tag.new(tag_params)

        if @tag.save
          render json: @tag, status: :created, location: @tag
        else
          render json: @tag.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/tags/1
      def update
        if @tag.update(tag_params)
          render json: @tag
        else
          render json: @tag.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/tags/1
      def destroy
        @tag.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_tag
        @tag = Tag.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tag_params
        params.require(:tag).permit(:locality)
      end
    end
  end
end
