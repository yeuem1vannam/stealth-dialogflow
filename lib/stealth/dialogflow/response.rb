require "ostruct"
require_relative "./client"

module Stealth
  module Dialogflow
    class Response
      def initialize(message, current_session:)
        @message = message
        @client = Client.new current_session
      end

      def intent
        query_result && query_result.intent.display_name
      end

      def action
        # TODO: query_result.action vs query_result.intent.action
        query_result && query_result.action
      end

      private

      def query_result
        @query_result ||=
          begin
            return nil unless @message.present?
            @client.detect_intent @message
          end
      end

      class << self
        def for(message, current_session:)
          new(message, current_session: current_session)
        end
      end
    end
  end
end
