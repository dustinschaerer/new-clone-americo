class EmailSender
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(email_message_id, prospect_group_id)
    email_message = EmailMessage.find(email_message_id)
    prospect_group = ProspectGroup.find(prospect_group_id)

    if email_message.recipients.kind_of?(Array)
      email_message.recipients.each do |relation|
        relation.find_each do |recipient|
          EmailMessageNotifier.delay.(email_message.name, recipient)
        end
      end
    end
  end

end