module RidesHelper
  def provider_list ids=''
    ids.gsub(/\,$/, '').split(',').collect{|i| Ride.providers[i.to_i]}.join(',')
  end
end
