require 'httparty'

module CloudflareApi
  class V4
    include HTTParty
    # debug_output $stdout

    base_uri 'https://api.cloudflare.com/client/v4'

    def initialize(email, key)
      self.class.headers(
        'X-Auth-Email' => email,
        'X-Auth-Key'   => key,
        'Content-Type' => 'application/json',
      )
    end

    def v4
      @_v4 ||= self.class
    end
  end

  class Zones < V4
    def zones
      v4.get('/zones').parsed_response['result']
    end

    ## helper to look up zone identifier for domain
    def zone_id(name)
      zones.find do |zone|
        zone['name'] == name
      end.fetch('id', nil)
    end

    def purge_everything(id)
      v4.delete("/zones/#{id}/purge_cache", body: {purge_everything: true}.to_json).parsed_response
    end
  end
end