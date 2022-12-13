module Intake
  class DetailsController < ApplicationController
    def new
      @detail = Detail.new
    end

    def create
      @detail = Detail.new(detail_params)
      if params[:back_button]
        redirect_to new_intake_category_path
      elsif @detail.valid?
        full_params = detail_params.merge(
          category: session['category']['category'],
          creator_id: current_user.id,
          status: 0,
          upvotes: 0
        )
        @alert = Alert.create!(full_params)
        @chatroom = Chatroom.create!(name: "Chat for Alert #{@alert.id}", alert_id: @alert.id)
        session.delete('detail')
        redirect_to alert_path(@alert), notice: "Thank you for sending your alert."
      else
        render :new, status: :unprocessable_entity
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
