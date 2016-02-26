#@todo: rode_date, from, to, provider_id validation
#@todo: privder_id hardcoded. Is separate model needed? doubtfull ;) 
class Ride < ActiveRecord::Base
  after_validation :geocode_all, if: :not_geocoded_by?

  def coords field = :from
    [self.send("#{field}_longitude"),self.send("#{field}_latitude")]
  end
  def geocoded_by
    %w(from to)
  end 
  protected
  #@todo: rescue, check first existance, distance validation
  def geocode_all
    geocoded_by.each do |field|
      # possible multiple values returned. check only first 
      lat,long = Geocoder.search(self.send(field)).first.data["geometry"]["location"].values
      self.send("#{field}_latitude=",lat)
      self.send("#{field}_longitude=",long)
    end
    self.distance = Geocoder::Calculations.distance_between(coords(:from), coords(:to))
  end

  private
  #@todo: rename to +=_or_chaned? if update/eidt needed ;)
  def not_geocoded_by?
    geocoded_by.each do |field|
      if self.send("#{field}_latitude".to_sym).nil? or  self.send("#{field}_longitude".to_sym).nil? 
      	return true
      end
    end
  end        
end
