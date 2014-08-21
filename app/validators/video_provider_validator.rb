class VideoProviderValidator < ActiveModel::EachValidator
  ALLOWED_PROVIDERS  = ['youtube.com', 'dailymotion.com', 'vimeo.com']

  def validate_each(record, attribute, value)
    begin
      uri = URI.parse(value)
      resp = ALLOWED_PROVIDERS.any? {|provider| uri.host.include? provider}
    rescue URI::InvalidURIError
      resp = false
    end

    unless resp == true
      record.errors[attribute] << (options[:message] || "wrong video provider")
    end
  end
end
