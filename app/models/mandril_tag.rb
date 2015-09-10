class MandrilTag < ActiveRecord::Base

  def title=(title)
    if title.blank?
      write_attribute(:title, subject.parameterize.dasherize)
    else
      write_attribute(:title, name.parameterize.dasherize)
    end
  end

  def get_mandrill_stats
    return if mandril_tag.blank?
    Mandrill::API.new.tags.info(mandril_tag)
    rescue Mandrill::InvalidTagNameError
      false
  end

end
