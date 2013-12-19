require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Americo Swatch Order Confirmation", mail.subject
    assert_equal ["tim@example.org"], mail.to
    assert_equal ["staff@americo-test.us"], mail.from
    assert_match /Thank you for your recent Sample Swatch order from Americo./, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Americo Swatch Order Shipped", mail.subject
    assert_equal ["tim@example.org"], mail.to
    assert_equal ["staff@americo-test.us"], mail.from
    assert_match /that we've shipped your recent Sample Swatch order/, mail.body.encoded
  end

end