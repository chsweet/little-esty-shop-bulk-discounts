class Admin::DashboardController < ApplicationController
  def index
    @top_five_customers = Customer.top_five
  end
end