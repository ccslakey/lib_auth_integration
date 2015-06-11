class WelcomeController < ApplicationController
  def index
  	# raising @books to class variable for rendering??
  	@books = Book.all
  	@book = Book.new
  	render :index
  end
end
