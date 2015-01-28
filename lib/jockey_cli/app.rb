module JockeyCli
  class App < Base
    self.path = '/apps'

    class << self
      def available_node(options = {})
        parsed_response get("#{path}/available_node", query: options)
      end
    end
  end
end
