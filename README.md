# Blubird
Blubird collects weather forecasts for different ski resorts accross the world, from multiple different sources, and analyzes this data to suggest which days would be ideal for your next ski trip.

Blubird is currently in it's prototype stage. It is not available to the public yet, but is being tested and refined and will eventually be available for Beta testing, hopefully next season! The prototype consists of a functioning backend that automatically [collects forecast data](#forecast-collection) from multiple different [sources](#forecast-sources) for each resort in the DB several times a day, and an endpoint to view the [average forecast data](#forecast-aggregation) for upcoming days at a particular resort.

## Blubird V1
Before deciding how to use this information, it's important to test some hypotheses about what makes a "perfect day", and what "perfect day" means to different types of riders. To do that, data must first be collected and tested against the reality of the riding conditions out on the mountain.

### V1 Objectives
1. Amass forecast data for multiple resorts
1. Analyze forecast accuracy of specific data sources against actual riding conditions
1. Continually build recommendation algorithm
1. Test accuracy of recommendations against actual riding conditions

The steps needed to achieve this, besides a ton of days on the mountain (heh), are as follows:
1. [Forecast collection](#forecast-collection)
1. [Forecast aggregation](#forecast-aggregation)
1. [Aggregate forecast analysis](#aggregate-forecast-analysis)
1. [Forecast categorization](#forecast-categorization)

## Forecast Collection
Blubird automatically collects forecast data for every resort in it's database every hour. This happens in parallel for every resort and forecast source. Weather forecasts are often unreliable and change frequently, so in an attempt to mitigate this, Blubird does not rely on a single source of forecast information. It may gather data from anything from a weather API to scraping a website of a ski resort. Where the information comes from is abstracted away from the [forecast aggregation](#forecast-aggregation), so as long as it fits a uniform format, it can be [analyzed](#aggregate-forecast-analysis)
### Forecast Sources
Blubird currently has 2 forecast sources that are used for every resort:
* [Dark Sky API](https://darksky.net/dev)
* [Weatherbit.io API](https://www.weatherbit.io/)

Some sources of the future might include individual websites of ski resorts, OpenSnow.com, etc.

## Forecast Aggregation
Blubird takes the forecasts, grouped by day, from all sources that are valid for a particular resort, and computes the average of data points such as:
* Wind speed
* High temperature
* Low temperature
* Probability of Precipitation
* Snow depth
* Expected snowfall

_One hypothesis that will be tested with the prototype is that average forecast data is better than data from one source. I've yet to prove it but it's worth testing._

## Aggregate Forecast Analysis
Coming soon. Currently researching the data being collected and fine-tuning the algorithm

## Forecast Categorization
Coming soon. A few potential categories for a ski day might range from `'bluebird'` to `'park_day'` to `'ice_hell'` to `'off_season'`.

## DB Schema
![DB Schema](https://i.imgur.com/UM6zPUA.png)
