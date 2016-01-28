require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest

fixtures :quotes
fixtures :lines

  test "ordering a catalog" do
    @user = FactoryGirl.create(:user)
    @emails = ActionMailer::Base.deliveries
    @emails.clear

    visit root_url
    click_link 'FREE Catalog'
    assert has_content? "Request a Free Catalog"
    click_link 'Add to Cart'
    assert_equal '/request_catalog', current_path
    assert has_content?("Added to your Cart"), "Did not display swatch successfully added message"
    assert has_selector? "h3", text: "Your Shopping Cart"
    assert has_content?("Free Catalog"), "Does not show Free Catalog text in cart"
    assert has_selector?(".line_item_entry img", count: 2), "Does not have one image in each of the carts line item rows"
    assert has_selector?("#side .line_item_entry img", count: 1), "Does not have one image in the side cart line item rows"
    assert has_selector?(".quantity", count: 2), "Does not have one quantity field in each of the carts line item rows"
    within("#side") do
      click_link "Checkout"
    end
    assert has_selector? "h3", text: "Your Shopping Cart"
    assert has_content?("Free Catalog"), "Does not show Free Catalog text in cart"
    assert has_selector?(".line_item_entry img", count: 3), "Does not have one image in each of the carts line item rows"
    assert has_selector?(".quantity", count: 3), "Does not have one quantity field in each of the carts line item rows"
    within("#order-checkout-button") do
      click_link "Checkout"
    end
    assert_equal "/users/sign_in", current_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
    assert has_content?("Logged in as #{@user.email}"), "Did not display Logged in as message"
    assert_equal "/orders/new", current_path
    order_count = Order.all.size
    fill_in('First Name', with: 'Tim')
    fill_in('Last Name', with: 'Smith')
    fill_in('Company', with: 'Example Company Name')
    fill_in('Street Address', with: '123 Way Street')
    fill_in('City', with: 'Vancouver')
    fill_in('Zip Code', with: '98682')
    select 'United States', from: "order_country"
    select 'Washington', from: "order_state"
    fill_in('Telephone Number', with: '555-555-5555')
    click_button 'Submit Order Now'
    assert_equal user_path(@user), current_path
    assert_equal order_count + 1, Order.all.size
    order = Order.last
    assert_equal "Tim",       order.firstname
    assert_equal "Smith",       order.lastname
    assert_equal "tim@example.org", order.email
    assert_equal "123 Way Street",  order.street_address
    assert_equal "Vancouver",       order.city
    assert_equal "Washington",       order.state
    assert_equal "United States",       order.country
    assert_equal "98682",       order.zipcode
    assert_equal 1, order.line_items.size
    assert_equal 2, ActionMailer::Base.deliveries.count
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["tim@example.org"], mail.to
    assert_equal 'ken@americo-inc.com', mail[:from].value
    assert_equal "Americo Swatch Order Confirmation", mail.subject
    within("#orders_table") do
      assert has_content? order.id
    end
    find("a[href='/orders/#{order.id}']").click
    assert_equal order_path(order), current_path
  end

  test "user can submit a quote" do
    @user = FactoryGirl.create(:user)
    @emails = ActionMailer::Base.deliveries
    @emails.clear

    visit root_url
    click_link "SIGN IN TO MY ACCOUNT", match: :first
    assert_equal "/users/sign_in", current_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
    assert has_content?("Logged in as #{@user.email}"), "Did not display Logged in as message"
    click_link "Request a Quote", match: :first
    assert_equal "/request_quote", current_path, "Incorrect path, not request quote path"
    click_link "Value Vinyl Roll Goods", match: :first
    assert has_content?("Value Vinyl Roll Goods"), "Page does not display Value Vinyl Roll Goods"
    select '7101', from: 'Series'
    select 'Cumin', from: 'Color'
    fill_in 'Quantity', with: 10
    click_button "Add Product to Quote Now"
    assert has_content?("Quote Item was successfully created and added to your Quoteholder."), "Page does not display the flash"
    assert has_content?("Quote Product: VALUE VINYL ROLL GOODS"), "Page does not display the Quote Product - VALUE VINYL ROLL GOODS"
    assert has_content?("7101"), "Page does not display the Series - 7101"
    assert has_content?("Cumin"), "Page does not display the color - Cumin"
    within("#total_price") do
      assert has_content? "$0.00"
    end
    quote_count = Quote.all.size
    click_link "Submit Quote for Pricing Now", match: :first
    fill_in('First Name', with: 'Tim')
    fill_in('Last Name', with: 'Smith')
    fill_in('Company', with: 'Example Company Name')
    fill_in('Telephone', with: '360-944-4444')
    select 'Email', from: 'Contact By'
    fill_in('Street Address', with: '123 Way Street')
    fill_in('City', with: 'Vancouver')
    fill_in('Zip Code', with: '98682')
    select 'United States', from: 'Country'
    select 'Washington', from: 'State/Province'
    click_button "Submit My Quote Now"
    assert_equal user_path(@user), current_path
    assert_equal quote_count + 1, Quote.all.size
    quote = Quote.last
    assert_equal "Tim",       quote.firstname
    assert_equal "Smith",       quote.lastname
    assert_equal "tim@example.org", quote.email
    assert_equal "360-944-4444",       quote.telephone
    assert_equal "Email",       quote.contactby
    assert_equal "123 Way Street",  quote.ship_street_address
    assert_equal "Vancouver",       quote.ship_city
    assert_equal "Washington",       quote.ship_state
    assert_equal "United States",       quote.ship_country
    assert_equal "98682",       quote.ship_zipcode
    assert_equal "Submitted",       quote.status
    assert_equal 1, quote.lines.size
    assert_equal 2, ActionMailer::Base.deliveries.count
    all_mails_retrieved = ActionMailer::Base.deliveries.pop
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["tim@example.org"], mail.to
    assert_equal 'ken@americo-inc.com', mail[:from].value
    assert_equal "Americo Quote Confirmation", mail.subject
    within("#quotes_table") do
      assert has_content? quote.id
    end
    find("a[href='/quotes/#{quote.id}']").click
    assert_equal quote_path(quote), current_path
  end

  test "user can make a purchase" do
    @user = FactoryGirl.create(:user, :id => 3)
    @quote_nine = quotes(:nine)
    @line_one = lines(:one)
    @line_two = lines(:two)

    visit root_url
    click_link "SIGN IN TO MY ACCOUNT", match: :first
    assert_equal "/users/sign_in", current_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
    assert_equal current_path, "/", "Should be at root path"
    assert has_content? "Logged in as"
    click_link "MY ACCOUNT", match: :first
    assert_equal user_path(@user), current_path
    assert_equal '/users/3', current_path
    assert has_content? "Hello, #{@user.email}"
    assert has_content? "My Quote Request History"

    find("a[href='/quotes/#{@quote_nine.id}']").click
    assert_equal quote_path(@quote_nine), current_path
    click_link "MY ACCOUNT", match: :first
    assert_equal user_path(@user), current_path
    find("a[href='/purchases/new?quote_id=#{@quote_nine.id}']").click
    assert has_content? "Secure Checkout"
    check "make_same_address"
    assert has_content? @quote_nine.subtotal
    assert has_content? @quote_nine.total
    fill_in "Card number", :with => "4111111111111111"
    fill_in "Card Verification Value (CVV)", :with => "111"
    select '2017', from: 'purchase_card_expires_on_1i'
    select '4 - April', from: 'purchase_card_expires_on_2i'
    click_on "Place Order Now"

  end

end