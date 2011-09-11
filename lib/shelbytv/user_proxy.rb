module Shelbytv
  class UserProxy
    def initialize(shelbytv)
      @shelbytv = shelbytv
    end

    def find(id)
      Shelbytv::User.new(@shelbytv, @shelbytv.get("users/#{id}.json").first)
    end
  end
end
