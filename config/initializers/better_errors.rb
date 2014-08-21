module BetterErrors
  def self.allow_remote
    @allow_remote
  end
  def self.allow_remote=(allow_remote=false)
    @allow_remote = allow_remote
  end

  class Middleware
    def call(env)
      if BetterErrors.allow_remote || ENV['BE_ALLOW_REMOTE']
        better_errors_call env
      else
        @app.call env
      end
    end
  end
end

BetterErrors.allow_remote = true if defined? BetterErrors
