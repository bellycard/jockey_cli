module JockeyCli
  class Reconcile < Base
    self.path = '/reconciles'

    class << self
      def preview(options = {})
        parsed_response post("#{path}/preview", body: options)
      end

      def logs(id, options={})
        parsed_response get("#{path}/#{id}/logs", query: options)
      end
    end
  end
end
