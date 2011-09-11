module Shelbytv
  class Broadcast
    FIELDS = [ :channel_id,
               :description,
               :name,
               :total_plays,
               :user_id,
               :user_nickname,
               :user_thumbnail,
               :video_description,
               :video_id_at_provider,
               :video_originator_user_image,
               :video_originator_user_name,
               :video_originator_user_nickname,
               :video_player,
               :video_provider_name,
               :video_thumbnail_url,
               :video_title,
               :video_user_id,
               :video_user_nickname,
               :video_user_thumbnail,
               :video_user_thumbnail,
               :watched_by_owner ]

    attr_reader :json

    def initialize(shelbytv, json)
      @shelbytv, @json = shelbytv, json
    end

    def id
      @json['_id']
    end

    def channel
      @shelbytv.channels.find(channel_id)
    end

    def created_at
      Time.parse(@json['created_at'])
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

    def watched_by_owner?
      watched_by_owner
    end
  end
end
