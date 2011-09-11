module Shelbytv
  class Channel
    FIELDS = [ :name, :user_id ]

    attr_reader :json

    def initialize(shelbytv, json)
      @shelbytv, @json = shelbytv, json
    end

    def id
      @json['_id']
    end

    def broadcasts(options={})
      @shelbytv.get("channels/#{id}/broadcasts.json", options).map do |item|
        Shelbytv::Broadcast.new(@shelbytv, item)
      end
    end

    def created_at
      Time.parse(@json['created_at'])
    end

    def is_public
      @json['public']
    end

    def is_public?
      is_public
    end

    def method_missing(method_name, *args)
      if FIELDS.include?(method_name)
        @json[method_name.to_s]
      else
        super
      end
    end

    def updated_at
      Time.parse(@json['created_at'])
    end

    def user
      @shelbytv.users.find(user_id)
    end
  end
end
