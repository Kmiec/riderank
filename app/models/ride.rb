class Ride < ActiveRecord::Base
  validates_presence_of :rode_date, :from, :to, :provider_id, :price
  after_validation :geocode_all, if: :not_geocoded_by?

  default_scope -> { order('rode_date DESC')}
  scope :geocoded, -> { where.not(distance:nil,from_latitude:nil,from_longitude:nil,to_latitude:nil,to_longitude:nil)}
  def self.providers
    {
      1=>'Sawa',
      2=>'Uber',
      3=>'MPT'
    }
  end

  def provider
    Ride.providers[self.provider_id]
  end

  def coords field = :from
    [self.send("#{field}_longitude"),self.send("#{field}_latitude")]
  end
  def geocoded_by
    %w(from to)
  end

  def self.stats_query
    subquery= '(SELECT group_concat(DISTINCT provider_id,",")) as pids'
    self.geocoded.select('rode_date,SUM(distance) as sum_ride, AVG(distance) as avg_ride, AVG(price) as avg_price, '+subquery).group(:rode_date)
  end
  protected  
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
