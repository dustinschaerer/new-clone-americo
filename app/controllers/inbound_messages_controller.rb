class InboundMessagesController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
end