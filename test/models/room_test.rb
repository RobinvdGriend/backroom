require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = Room.new(name: "Example Room")
  end

  test "should be valid" do
    assert @room.valid?
  end

  test "name should be non-blank" do
    @room.name = ""
    assert_not @room.valid?
  end

  test "name should have minimum length" do
    @room.name = "a" * 2
    assert_not @room.valid?
  end

  test "name should not exceed maximum length" do
    @room.name = "a" * 51
    assert_not @room.valid?
  end
end
