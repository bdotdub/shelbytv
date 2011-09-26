require 'oauth/signature/plaintext'

module Shelbytv
  class Base
    API = "http://api.shelby.tv/v2/"

    attr_accessor :auth_token, :auth_secret, :request_token

    def initialize(*args)
      if args.size == 2
        @consumer_key, @consumer_secret = args
      elsif args.size == 4
        @consumer_key, @consumer_secret, @auth_token, @auth_secret = args
      else
        raise ArgumentError, "You need to pass in the consumer tokens as well as the auth tokens"
      end
    end

    def channels
      Shelbytv::ChannelProxy.new(self)
    end

    def user
      Shelbytv::User.new(self, get('users.json').first)
    end

    def users
      Shelbytv::UserProxy.new(self)
    end

    def get(path, params={})
      query = params.map { |k,v| "#{k}=#{v}" }.join("&")
      JSON.parse(client.get(API + path + "?" + OAuth::Helper.escape(query)).body)
    end

    def post(path, params={})
      JSON.parse(client.get(API + path, params))
    end

    def authorize_url
      consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, { :site=>"http://dev.shelby.tv" })
      @request_token = consumer.get_request_token
      @request_token.authorize_url
    end

    def access_token(oauth_verifier)
      @request_token.get_access_token(:oauth_verifier => oauth_verifier)
    end

  private

    def client
      consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, { :signature_method => 'PLAINTEXT' })
      OAuth::AccessToken.new(consumer, @auth_token, @auth_secret )
    end

  end
end
