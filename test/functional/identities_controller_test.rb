require 'test_helper'

class IdentitiesControllerTest < ActionController::TestCase
  #setup do
  #  @identity = identities(:one)
  #end

  #test "should get index" do
  #  get :index
  #  assert_response :success
  #  assert_not_nil assigns(:identities)
  #end

  #test "should create identity" do
  #  assert_difference('Identity.count') do
  #    post :create, :identity => @identity.attributes
  #  end

  #  assert_redirected_to identity_path(assigns(:identity))
  #end

  #test "should destroy identity" do
  #  assert_difference('Identity.count', -1) do
  #    delete :destroy, :id => @identity.to_param
  #  end

  #  assert_redirected_to identities_path
  #end
  context "check routes" do
    should 'recognize openid route' do
      assert_recognizes({ :controller => 'identities',
                          :action => 'show_by_username',
                          :username=> "flavio+1" },
                         "/openid/flavio+1")
    end
  end

  context 'GET :show_by_username' do
    context "invalid identity" do
      setup do
        get :show_by_username, :username => "invalid"
      end
      should respond_with(:bad_request)
    end

    context "valid identity" do
      setup do
        @identity = Factory(:identity)
      end

      should "handle simple url" do
        get :show_by_username, :username => @identity.name
        assert_response :success

        assert_equal @identity, assigns(:identity)
        assert_select( 'head > link[rel="openid.delegate"]').each do |match|
          assert_equal @identity.openid_delegate, match["href"]
        end
        assert_select( 'head > link[rel="openid.server"]').each do |match|
          assert_equal @identity.openid_server, match["href"]
        end
      end

      should "handle complex url" do
        get :show_by_username, :username => "#{@identity.name}+123"
        assert_response :success
        assert_equal @identity, assigns(:identity)
        assert_select( 'head > link[rel="openid.delegate"]').each do |match|
          assert_equal @identity.openid_delegate, match["href"]
        end
        assert_select( 'head > link[rel="openid.server"]').each do |match|
          assert_equal @identity.openid_server, match["href"]
        end
      end
    end
  end


end
