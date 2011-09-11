module Shelbytv
  class ChannelProxy
    def initialize(shelbytv)
      @shelbytv = shelbytv
    end

    def all(options={})
      @shelbytv.get('channels.json', options).map do |item|
        Shelbytv::Channel.new(@shelbytv, item)
      end
    end

    def find(id)
      Shelbytv::Channel.new(@shelbytv, @shelbytv.get("channels/#{id}.json").first)
    end
  end
end
