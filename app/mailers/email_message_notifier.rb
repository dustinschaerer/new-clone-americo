class EmailMessageNotifier < ActionMailer::Base
  default from: "ken@americo-inc.com"

  def question(order, current_user)
    @order = order
    @current_user = current_user
    mail to: order.email, subject: "Response needed to ship Americo Order ##{@order.id}"
  end

  def prospect_welcome_to_americo(prospect, email_message)
    @prospect = prospect
    @email_message = email_message
    mail to: prospect.email, subject: "#{@email_message.subject}"
  end

  def user_table_covers_we_missed_you(user, email_message)
    @user = user
    @email_message = email_message
    mail to: user.email, subject: "#{@email_message.subject}"
  end

  def user_roll_goods_we_missed_you(user, email_message)
    @user = user
    @email_message = email_message
    mail to: user.email, subject: "#{@email_message.subject}"
  end

  def dynamic_message(recipient, email_message)
    @email_message = email_message
    text_content = @email_message.text_content
    content = @email_message.content

    if recipient.class.name == "User"
      @user = recipient
      @email = @user.email
      if content.include? "UnsubscribeLinkGenerator"
        user_id = @user.id
        sub_content = content.gsub("UnsubscribeLinkGenerator", "users/edit")
      end
      if text_content.include? "UnsubscribeLinkGenerator"
        user_id = @user.id
        sub_text_content = text_content.gsub("UnsubscribeLinkGenerator", "users/edit")
      end

    elsif recipient.class.name =="Prospect"
      @prospect = recipient
      @email = @prospect.email
      if content.include? "UnsubscribeLinkGenerator"
        prospect_id = @prospect.id
        sub_content = content.gsub("UnsubscribeLinkGenerator", "prospects/#{prospect_id.to_s}?unsubscribe_from_emails=1")
      end
      if text_content.include? "UnsubscribeLinkGenerator"
        prospect_id = @prospect.id
        sub_text_content = text_content.gsub("UnsubscribeLinkGenerator", "prospects/#{prospect_id.to_s}?unsubscribe_from_emails=1")
      end

    elsif recipient.class.name =="InhouseCustomer"
      @inhouse_customer = recipient
      @email = @inhouse_customer.email
       if content.include? "UnsubscribeLinkGenerator"
        inhouse_customer_id = @inhouse_customer.id
        sub_content = content.gsub("UnsubscribeLinkGenerator", "inhouse_customers/#{inhouse_customer_id.to_s}?unsubscribe_from_emails=1")
      end
      if text_content.include? "UnsubscribeLinkGenerator"
        inhouse_customer_id = @inhouse_customer.id
        sub_text_content = text_content.gsub("UnsubscribeLinkGenerator", "inhouse_customers/#{inhouse_customer_id.to_s}?unsubscribe_from_emails=1")
      end

    else
      sub_content = content
      sub_text_content = text_content
    end

    @sub_content = sub_content
    @sub_text_content = sub_text_content

      #######################################
      # Refactor in accordance with UserGroup.kind and ProspectGroup.kind
      #########################################
      # if @email_message.headers == 'purchase'
      #   if @user.purchases.last
      #     # if this user has at least 1 purchase
      #     # find their last purchase and determine if it was for
      #     # table covers or for roll goods/upholstery
      #     @user.purchases.last.created_at.strftime("%B %d, %Y")
      #   end
      # elsif @email_message.headers == 'quote'
      #   if @user.quotes.last
      #     # if this user has at least 1 quote
      #
      #     # find their last quote details and determine if it was for
      #     # table covers OR roll goods/upholstery
      #     @user.quotes.last.created_at.strftime("%B %d, %Y")
      #   end
      # elsif @email_message.headers == 'order'
      #   if @user.orders.last
      #     # if this user has at least 1 order (catalog)
      #     @user.orders.last.created_at.strftime("%B %d, %Y")
      #   end
      # else
      #
      # end

    headers['X-MC-Tags'] = @email_message.mandril_tag
    mail({
     to: @email,
     subject: "#{@email_message.subject}"
    })
  end
end
