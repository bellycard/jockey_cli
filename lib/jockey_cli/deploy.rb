module JockeyCli
  class Deploy < Base
    self.path = '/deploys'

    def self.logs(id, options={})
      parsed_response get("#{path}/#{id}/logs", query: options)
    end
  end
end
