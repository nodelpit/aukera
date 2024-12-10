require "test_helper"

class MoviesPlaylistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get movies_playlists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get movies_playlists_destroy_url
    assert_response :success
  end
end
