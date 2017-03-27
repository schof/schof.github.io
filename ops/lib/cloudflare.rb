require 'awful/param'
require_relative 'cloudflare_api'

module Stax
  class Cloudflare < Cli
    no_commands do
      def param_get(key)
        param(:get, [key], decrypt: true, quiet: true).first&.value
      end

      def email
        @_email ||= param_get('CLOUDFLARE_EMAIL')
      end

      def api_key
        @_api_key ||= param_get('CLOUDFLARE_API_KEY')
      end

      def client
        @_client ||= CloudflareApi::Zones.new(email, api_key)
      end

      def domain
        @_domain ||= 'dumpcomstock.com'
      end

      def zone_id
        @_zone_id ||= client.zone_id(domain)
      end
    end

    desc 'zone', 'zone ID'
    def zone
      debug("Coudflare zone identifier for #{domain}")
      puts zone_id
    end

    desc 'test', 'test'
    def purge
      debug("Purging all files in Cloudflare cache for #{domain}")
      p client.purge_everything(zone_id)
    end

  end

  class Cli < Base
    desc 'cloudflare', 'cloudflare tasks'
    subcommand 'cloudflare', Cloudflare
  end
end