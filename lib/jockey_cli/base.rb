module JockeyCli
  class Base
    include HTTParty
    base_uri JockeyCli.configuration.base_url
    format :json
    default_params github_access_token: JockeyCli.configuration.github_access_token

    class << self
      attr_accessor :path

      def parsed_response(response)
        Hashie::Mash.new(response)
      end

      def filter(options = {})
        parsed_response get(path, query: options)
      end

      def find(id, options = {})
        parsed_response get("#{path}/#{id}", query: options)
      end

      def create(data)
        parsed_response post(path, body: data)
      end

      def update(id, data)
        parsed_response put("#{path}/#{id}", body: data)
      end

      def destroy
        raise 'not implemented'
      end
    end
  end
end
