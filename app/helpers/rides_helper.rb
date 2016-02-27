module RidesHelper
  def provider_list ids=''
    (ids.split(',')-['']).collect{|i| Ride.providers[i.to_i]}.join(',')
  end
end
