require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
 context "validation" do
    setup do
      @identity = Factory.create(:identity)
    end

    should belong_to(:user)
    should validate_uniqueness_of(:name)
    should validate_presence_of(:name)

    should "pass all valadations" do
      [:openid_server,:openid_delegate,:openid_url].each do |url_attribute|
        assert(validate_presence_of(url_attribute))
        !assert(allow_value("broken_url").for(url_attribute))
        !assert(allow_value("").for(url_attribute))
        !assert(allow_value(nil).for(url_attribute))
        !assert(allow_value("http:/example.com").for(url_attribute))
        assert(allow_value("http://example.com").for(url_attribute))
      end
    end
  end

end

