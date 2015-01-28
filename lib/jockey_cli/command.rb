module JockeyCli
  class Command < Base
    self.path = '/one_time_commands'

    class << self
      def deploys(id, options = {})
        parsed_response get("#{path}/#{id}/deploys", query: options)
      end
    end
  end
end
