class SubscriberNotification < ActionMailer::Base
  default from: 'ken@americo-inc.com'

  def new_signup(subscriber)
    @subscriber = subscriber

    mail to: subscriber.email, subject: 'Americo Subscription Notice'
  end

end
