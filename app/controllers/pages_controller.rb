class PagesController < ApplicationController
  include HighVoltage::StaticPage

  skip_before_action :require_login, only: [:show]
end
