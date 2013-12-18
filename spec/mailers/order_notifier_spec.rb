require "spec_helper"

describe OrderNotifier do
  
  describe 'received' do
  
    let(:order) { mock_model(Order, :name => 'Dustin Schaerer',
                                    :ship_street_address => '123 Way Street',
                                    :ship_city => 'Vancouver',
                                    :ship_state => 'Washington', 
                                    :ship_country => 'United States', 
                                    :telephone => '555-555-5555',
                                    :email => 'test@gmail.com'
                                    ) }
    let(:mail) { OrderNotifier.received(order) }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == 'Americo Swatch Order Confirmation'
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [order.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ['Dustin Schaerer <staff@americo-test.us>']
    end
 
    #ensure that the received information text is in the email body
    it 'contains received information text' do
      mail.body.encoded.should match("send you a separate e-mail when your order ships.")
    end
  end

  describe "shipped" do

    let(:order) { mock_model(Order, :name => 'Dustin Schaerer',
                                    :ship_street_address => '123 Way Street',
                                    :ship_city => 'Vancouver',
                                    :ship_state => 'Washington', 
                                    :ship_country => 'United States', 
                                    :telephone => '555-555-5555',
                                    :email => 'test@gmail.com'
                                    ) }
    
    let(:mail) { OrderNotifier.shipped(order) }

    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == 'Americo Swatch Order Shipped'
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [order.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ['Dustin Schaerer <staff@americo-test.us>']
    end
 
    #ensure that the shipped information text is in the email body
    it 'contains received information text' do
      mail.body.encoded.should match("we've shipped your recent Sample Swatch order containing:")
    end

  end

end
