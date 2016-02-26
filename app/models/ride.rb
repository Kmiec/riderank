#@todo: rode_date, from, to, provider_id validation
#@todo: privder_id hardcoded. Is separate model needed? doubtfull ;) 
class Ride < ActiveRecord::Base
  validates_presence_of :rode_date, :from, :to, :provider_id, :price, :distance
  after_validation :geocode_all, if: :not_geocoded_by?

  def self.providers
    {
      1=>'Sawa',
      2=>'Uber',
      3=>'MPT'
    }
  end

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
      if g_data = Geocoder.search(self.send(field)).first
        lat,long = g_data.data["geometry"]["location"].values
        self.send("#{field}_latitude=",lat)
        self.send("#{field}_longitude=",long)
      end
    end
    self.distance = Geocoder::Calculations.distance_between(coords(:from), coords(:to)) unless not_geocoded_by?
  end
  private
  #@todo: rename to +=_or_chaned? if update/edit needed ;)
  def not_geocoded_by?
    geocoded_by.each do |field|
      if self.send("#{field}_latitude".to_sym).nil? or  self.send("#{field}_longitude".to_sym).nil? 
      	return true
      end
    end
    false
  end        
end
