module Intake
  class CategoriesController < ApplicationController
    extend ActiveSupport::Concern
    included do
      before_action :authenticate_user!, only: %i[new]
    end
    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.valid?
        session[:category] = {
          'category' => @category.category
        }
        redirect_to new_intake_detail_path
      else
        render :new
      end
    end

    private

    def category_params
      params.require(:intake_category).permit(
        :category
      )
    end
  end
end
