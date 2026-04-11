class Api::V1::OilSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pull
    status = OilPriceScraper.call
    if status[:success]
      render json: status, status: 200
    else
      render json: status, status: 400
    end
  end

  def list
    oil_type = params[:oilType]

    if oil_type.blank?
      render json: { success: false, message: "Please provid OilType" }, status: 400
    end

    if oil_type === "All"
      oil_prices = OilPrice.where("date >= ?", 7.days.ago.to_date).order(date: :desc)

      @group_oil = oil_prices.group_by(&:fuel_type).map do |type, records|
        {
          fuel_type: type,
          history: format(records)
        }
      end
      render json: { success: true, oil: @group_oil }

    else
     oil_prices = OilPrice.where(fuel_type: oil_type).where("date >= ?", 7.days.ago.to_date).order(date: :desc)

     format_data = format(oil_prices)

     @oil = { fuel_type: oil_type, history: format_data }

     render json: { success: true, oil: @oil }
    end
  end

  private
  def params_filter
    params.permit(:oilType)
  end

  def format(oil)
    format_data = oil.map do |item|
      "#{item.date.strftime("%d/%m/%Y")} : #{item.price} baht"
    end
    format_data
  end
end
