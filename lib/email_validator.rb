require 'resolv'

class EmailValidator

  def initialize(email, check_mx = true)
    @email = email
    @domain = @email.split('@').last
    @check_mx = check_mx
  end

  DISPOSABLE_DOMAINS = YAML::load(File.open(Rails.root.join('lib', 'disposable_domains.yml').to_s))

  def valid?
    @domain && !disposable_domain? && valid_format_and_mx?
  end

  def valid_format_and_mx?
    ValidatesEmailFormatOf::validate_email_format(@email, check_mx: @check_mx).nil?
  end

  def disposable_domain?
    DISPOSABLE_DOMAINS.include?(@domain)
  end

end