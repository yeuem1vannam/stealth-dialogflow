require "securerandom"
require_relative "./response"

module Stealth
  class ServiceMessage
    def dialogflow(current_session = SecureRandom.uuid)
      @dialogflow ||= Stealth::Dialogflow::Response.for(
        message, current_session: current_session
      )
    end
  end
end
