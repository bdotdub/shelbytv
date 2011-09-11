module Shelbytv
  class User
    FIELDS = [ :name,
               :nickname,
               :total_videos_played,
               :user_image ]

    attr_reader :json

    def initialize(shelbytv, json)
      @shelbytv, @json = shelbytv, json
    end

    def id
      @json['_id']
    end

    def created_at
      Time.parse(@json['created_at'])
    end

    def channels(options={})
      @shelbytv.get("channels.json", options).map do |item|
        Shelbytv::Channel.new(@shelbytv, item)
      end
    end

    def method_missing(method_name, *args)
      if FIELDS.include?(method_name)
        @json[method_name.to_s]
      else
        super
      end
    end

    def profile_image
      user_image
    end
  end
end
