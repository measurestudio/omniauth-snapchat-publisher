require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Snapchat < OmniAuth::Strategies::OAuth2

      option :name, 'snapchat'

      option :client_options, {
        :site          => 'https://api.snapchat.com',
        :authorize_url => 'https://accounts.snapchat.com/login/oauth2/authorize',
        :token_url     => 'https://accounts.snapchat.com/login/oauth2/access_token'
      }

      uid { raw_info.dig('data', 'me', 'externalId') }

      info do
        {
          display_name: raw_info.dig('data', 'me', 'displayName'),
          external_id: raw_info.dig('data', 'me', 'externalId'),
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        raw_info_url = "https://kit.snapchat.com/v1/me"
        params = { query: '{ me { externalId displayName } }' }
        @raw_info ||= access_token.get(raw_info_url, params: params).parsed
      end

      private

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
