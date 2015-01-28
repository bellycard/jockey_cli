module JockeyCli
  class Build < Base
    self.path = '/builds'

    def self.logs(id, options={})
      parsed_response get("#{path}/#{id}/logs", query: options)
    end
  end
end
