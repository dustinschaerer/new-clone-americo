class EmailMessage < ActiveRecord::Base

  validates_presence_of :subject, :content, :text_content
  has_many :prospect_groups, as: :sendable
  has_many :user_groups, as: :sendable
  has_many :prospects, as: :sendable
  has_many :users, as: :sendable
#  has_many :sent_emails, as: :sendable
  has_many :sent_emails

  def mandril_tag=(tag)
    if mandril_tag.blank?
      write_attribute(:mandril_tag, subject.parameterize.dasherize)
    else
      write_attribute(:mandril_tag, tag.parameterize.dasherize)
    end
  end

  def get_mandrill_stats
    return if mandril_tag.blank?
    Mandrill::API.new.tags.info(mandril_tag)
    rescue Mandrill::InvalidTagNameError
      false
  end

end