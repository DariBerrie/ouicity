module Intake
  class DetailsController < ApplicationController
    def new
      @detail = Detail.new
    end

    def create
      @detail = Detail.new(detail_params)
      if params[:back_button]
        redirect_to new_intake_category_path()
      elsif @detail.valid?
        full_params = detail_params.merge(
          category: session['category']['category'],
          creator_id: current_user.id,
          status: 0,
          upvotes: 0
        )

        Alert.create!(full_params)

        session.delete('detail')

        redirect_to alert_path(@alert)
      else
        render :new
      end
    end

    private

    def detail_params
      params.require(:intake_detail).permit(
        :title,
        :description,
        :address,
        :status,
        :upvotes,
        photos: []
      )
    end
  end
end
