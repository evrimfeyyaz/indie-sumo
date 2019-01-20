class StaticPagesController < ApplicationController
  def newsletter
  end

  def about
  end

  def loader_io_verification_staging
    render plain: 'loaderio-af1f76c262397ab753e3f2ef4dc64834'
  end

  # Error pages

  def not_found
    render status: 404
  end

  def unprocessable_entity
    render status: 422
  end

  def internal_server_error
    render status: 500
  end
end