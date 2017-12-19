require 'test_helper'

class ItemsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:rick)
  end

  test "item interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Item.count' do
      post items_path, params: { item: { brand: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    brand = "Ampeg"
    assert_difference 'Item.count', 1 do
      post items_path, params: { item: { brand: "Ampeg", model: "SVT" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match brand, response.body
    # Delete post
    assert_select 'a', text: 'delete'
    first_item = @user.items.paginate(page: 1).first
    assert_difference 'Item.count', -1 do
      delete item_path(first_item)
    end
    # Visit different user (no delete links)
    get user_path(users(:morty))
    assert_select 'a', text: 'delete', count: 0
  end

  # test "item sidebar count" do
  #   log_in_as(@user)
  #   get root_path
  #   assert_match "#{FILL_IN} items", response.body
  #   # User with zero items
  #   other_user = users(:malory)
  #   log_in_as(other_user)
  #   get root_path
  #   assert_match "0 items", response.body
  #   other_user.items.create!(content: "A item")
  #   get root_path
  #   assert_match FILL_IN, response.body
  # end
end
