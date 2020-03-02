namespace :forecasts do
  desc 'Collect current and upcoming forecast data for all Resorts'
  task collect: :environment do
    # TODO: Logging
    Resort.pluck(:id).each do |resort_id|
      Forecasts::BulkCollectionWorker.perform_async(resort_id)
    end
  end
end
