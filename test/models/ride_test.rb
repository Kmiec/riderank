require 'test_helper'

class RideTest < ActiveSupport::TestCase
  test "Invalid ride with no `from` shouldn't be saved" do
     r = Ride.create(to:'Somewhere',price:11.23,provider_id:1)
     assert !r.persisted?, 'Bad record saved'
  end
  test "Invalid ride with no `to` shouldn't be saved" do
     r = Ride.create(from:'Somewhere',price:11.23,provider_id:1)
     assert !r.persisted?, 'Bad record saved'
  end
  test "Invalid ride with no `price` shouldn't be saved" do
     r = Ride.create(to:'Somewhere',from:'Somewhere',provider_id:1)
     assert !r.persisted?
  end
  test "Invalid ride with no `provider` shouldn't be saved" do
     r = Ride.create(to:'Somewhere',from:'Somewhere',price:12.34)
     assert !r.persisted?
  end
  test "Ride with not resolved coordinates should be persisted" do
     r = Ride.create(to:'Somewhere',from:'Somewhere',price:12.34,provider_id:1)
     assert r.persisted?, 'Coordiante shouldn`t be a problem'
  end
  test "Ride without rode date should be persisted" do
     r = Ride.create(to:'Somewhere',from:'Somewhere',price:12.34,provider_id:1)
     assert r.persisted?, 'rode_date should default to `Date.today`'
  end

  test "Invalid ride shouldn'n be used for stats" do
     assert false, 'Not geocoded and without distance ride shouldn`t appear here!'
  end
end
