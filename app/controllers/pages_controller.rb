class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :show, :index]

  def home
  end

  def show
  end

  def index
  end
end
