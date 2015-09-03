class InboundMessagesController < ApplicationController
  include Mandrill::Rails::WebHookProcessor, MessageInfo

  # def handle_inbound(event_payload)
  #   Item.save_inbound_mail(event_payload)
  # end

  def handle_send(event_payload)
    # Item.save_send_mail(event_payload)
    if event_payload['sent']
      # Do I need to increment
    end
  end

  def handle_opens(event_payload)

  end

  def handle_clicks(event_payload)

  end

  def handle_hard_bounces(event_payload)

  end

  def handle_soft_bounces(event_payload)

  end

end
