require "google/cloud/dialogflow"

module Stealth
  module Dialogflow
    class Client
      def initialize(current_session)
        @current_session = current_session
      end

      def session
        @session ||= session_client.class
          .session_path(ENV["GOOGLE_CLOUD_PROJECT"], @current_session)
      end

      def session_client
        @session_client ||= Google::Cloud::Dialogflow::Sessions.new
      end

      def detect_intent(text)
        language_code = ENV["LANG"] || "en_US"
        query_input = { text: { text: text, language_code: language_code } }
        response = session_client.detect_intent session, query_input

        Stealth::Logger.l topic: "dialogflow", message: response.query_result
        response.query_result
      end
    end
  end
end
