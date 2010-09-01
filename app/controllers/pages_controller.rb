class PagesController < ApplicationController
  def index
     redirect_to client_path(@client) if defined?(@client)
  end
end