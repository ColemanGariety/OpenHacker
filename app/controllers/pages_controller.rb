class PagesController < ApplicationController

  skip_before_filter :authenticate

  def about
  end
end