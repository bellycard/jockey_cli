module JockeyCli
  class Worker < Base
    self.path = '/workers'

    class << self
      def deploys(id, options = {})
        parsed_response get("#{path}/#{id}/deploys", query: options)
      end

      def restart(data)
        parsed_response put("#{path}/restart", body: data)
      end
    end
  end
end
