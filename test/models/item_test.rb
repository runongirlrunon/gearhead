require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @user = users(:rick)
    # This code is not idiomatically correct.
    @item = @user.items.build(brand: "Fender",
                              model: "Stratocaster",
                              ssn: "AB1234",
                              cost: "1400",
                              user_id: @user.id)
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "user id should be present" do
    @item.user_id = nil
    assert_not @item.valid?
  end

  test "brand should be present" do
    @item.brand = "   "
    assert_not @item.valid?
  end

  test "model should be present" do
    @item.model = "   "
    assert_not @item.valid?
  end

  test "order should be most recent first" do
    assert_equal items(:bass), Item.first
  end
end
