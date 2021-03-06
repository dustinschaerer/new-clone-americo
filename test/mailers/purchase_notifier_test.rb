require 'test_helper'

class PurchaseNotifierTest < ActionMailer::TestCase
  test "confirmation" do
    mail = PurchaseNotifier.confirmation(purchases(:one), users(:user_one))
    assert_equal "Americo Purchase Confirmation", mail.subject
    assert_equal ["tim@example.org"], mail.to
    assert_equal ["ken@americo-inc.com"], mail.from
    assert_match /Your purchase at americo-inc.com is complete!/, mail.body.encoded
  end

  test "shipped" do
    mail = PurchaseNotifier.shipped(purchases(:one), users(:user_one))
    assert_equal "Americo Purchase has Shipped", mail.subject
    assert_equal ["tim@example.org"], mail.to
    assert_equal ["ken@americo-inc.com"], mail.from
    assert_match /Your Americo Order has Shipped!/, mail.body.encoded
  end

end