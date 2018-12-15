class StaticPagesController < ApplicationController
  def newsletter
  end

  def loader_io_verification_staging
    render plain: 'loaderio-af1f76c262397ab753e3f2ef4dc64834'
  end
end