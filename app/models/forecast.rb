class Forecast < ApplicationRecord
  validates :type,         presence: true
  validates :date,         presence: true
  validates :weather_data, presence: true

  belongs_to :resort

  def self.resort_aggregate(resort_uid)
    {
      'forecasts' => ActiveRecord::Base.connection.execute(aggregate_query(resort_uid))
    }
  end

  def self.aggregate_query(resort_uid)
    # This statement is built in raw SQL to boost performance by making less
    # calls to the DB, and not building Ruby objects for every forecast.
    # We leverage ActiveRecord validations when writing this data, so we know
    # we can trust it and pull it directly from the DB.
    select_statement = <<-EOS
      date,
      STRING_AGG(weather_data ->> 'precip_type', '-')     as agg_precip_type,
      AVG((weather_data ->> 'precip_prob')::numeric)::int as avg_precip_prob,
      AVG((weather_data ->> 'hi_temp')::numeric)::int     as avg_hi_temp,
      AVG((weather_data ->> 'lo_temp')::numeric)::int     as avg_lo_temp,
      AVG((weather_data ->> 'visibility')::numeric)::int  as avg_vis,
      AVG((weather_data ->> 'wind_speed')::numeric)::int  as avg_wind_spd,
      AVG((weather_data ->> 'snow_depth')::numeric)::int  as avg_snow_depth,
      AVG((weather_data ->> 'snowfall')::numeric)::int    as avg_snowfall
    EOS

    # Build the query with ActiveRecord first to avoid any string interpolation
    # or potential SQL injection (though unlikely)
    joins(:resort)
      .where('resorts.uid': resort_uid)
      .where('date > ?', Date.yesterday)
      .group(:date)
      .order(:date)
      .select(select_statement)
      .to_sql
  end
end

