require "securerandom"
require_relative "./response"

module Stealth
  class ServiceMessage
    def dialogflow(current_session = nil)
      @dialogflow ||=
        begin
          session = current_session.try(:session) || SecureRandom.uuid
          dialogflow_session = "#{sender_id}--#{session}"
          Stealth::Dialogflow::Response.for(
            message,
            current_session: dialogflow_session
          )
        end
    end
  end
end
