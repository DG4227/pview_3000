class PhotoLinksController < ApplicationController

  def show
    send_file photo_path, type: 'image/jpeg', disposition: 'inline'
  end

  def index
    scope = if filter_params[:relation] == "greater"
      PhotoLink.larger_than(filter_params[:columns].to_i, filter_params[:rows].to_i)
    elsif filter_params[:relation] == "lesser"
      PhotoLink.smaller_than(filter_params[:columns].to_i, filter_params[:rows].to_i)
    else
      PhotoLink.all
    end
    ids = scope.offset(filter_params[:offset]).limit(limit).pluck(:id)
    render json: ids, status: :ok
  end

  private

  def limit
    @limit ||= (params[:limit] || 10)
  end

  def filter_params
    params.permit(:columns, :rows, :offset, :relation)
  end

  def photo_path
    return photo_link.relative_filepath unless grayscale?
    photo_link.grayscale_relative_filepath
  end

  def grayscale?
    params[:grayscale].present? && params[:grayscale] == 'true'
  end

  def photo_link
    @photo_link ||= PhotoLink.find(params[:id])
  end
end
