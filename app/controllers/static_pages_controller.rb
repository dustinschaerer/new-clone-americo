class StaticPagesController < ApplicationController
  include CurrentCart
  include CurrentQuoteholder
  before_action :set_cart
  before_action :set_quoteholder
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def home
  	@subscriber = Subscriber.new
  end

  def help
  end

  def about
  end

  def americlear_laminations_sample
  end

  def cleaning_instructions
  end

  def contact
  end

  def credit_application
  end

  def free_swatches
  end

  def frequently_asked_questions
  end

  def how_to_measure
  end

  def how_to_order
  end

  def markets
  end

  def order_submitted
  end

  def photo_gallery
  end

  def quote_requested
  end

  def quote_system
  end

  def purchase_completed
  end

  def request_catalog
  end

  def request_quote
  end

  def roll_goods
  end

  def satisfied_customers
  end

  def sitemap
  end

  def table_cover_gallery
  end

  def technical_specs
  end

  def terms_and_conditions
  end

  def tradeshows
  end
end
