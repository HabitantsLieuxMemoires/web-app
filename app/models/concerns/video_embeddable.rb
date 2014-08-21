module VideoEmbeddable
  extend ActiveSupport::Concern

  def embedded
    VideoInfo.new(self.url).embed_code
  end

end
