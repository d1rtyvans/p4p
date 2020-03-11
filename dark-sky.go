package main

import (
    "fmt"
    "net/http"
    "encoding/json"
    "io/ioutil"
    "log"
    "os"
    "time"
    "database/sql"

    "github.com/joho/godotenv"
    _ "github.com/lib/pq"
)


var darkSkyApiKey string
var db *sql.DB

const (
    darkSkyUrl = "https://api.darksky.net"
    dbHost = "localhost"
    dbPort = 5432
    dbUser = "postgres"
    dbName = "p4p_development"
)

type ForecastResponse struct {
    Daily DailyForecastSet `json:"daily"`
}

type DailyForecastSet struct {
    Data []Forecast `json:"data"`
}

type Forecast struct {
    Time       int64   `json:"time"`
    TempHi     float64 `json:"temperatureHigh"`
    TempLo     float64 `json:"temperatureLow"`
    Visibility float64 `json:"visibility"`
    WindSpd    float64 `json:"windSpeed"`
    PrecipProb float64 `json:"precipProbability"`
    PrecipType string  `json:"precipType"`
}

type Resort struct {
    Id  int
    Uid string
    Lat float64
    Lon float64
    Forecasts []Forecast
}

func main() {
    loadApiKey()
    db = connectToDB()
    defer db.Close()

    // handle err
    resorts := allResorts()

    chResorts := make(chan Resort)

    for _, resort := range resorts {
        go collectForecasts(resort, chResorts)
    }

    // TODO: Upsert all at once instead of iterating...
    // OR CREATE THEM IN GOROUTINES AND PASS BACK ERRORS!!!!
    for i := 0; i < len(resorts); i++ {
        resort := <-chResorts
        // err handling?
        for _, forecast := range resort.Forecasts {
            createForecast(forecast, resort)
        }
    }
}

func createForecast(forecast Forecast, resort Resort) {
    sqlStatement := `
    INSERT INTO forecasts (type, date, weather_data, resort_id, created_at, updated_at)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING id;`

    date := time.Unix(forecast.Time, 0).Format(time.UnixDate)
    timestamp := time.Now()

    weatherData, err := json.Marshal(&forecast)
    if err != nil {
        panic(err)
    }

    var forecastId int
    err = db.QueryRow(sqlStatement, "DarkSkyForecast", date, weatherData, resort.Id, timestamp, timestamp).Scan(&forecastId)

    if err != nil {
        panic(err)
    }

    fmt.Println("New forecast ID is:", forecastId)
}

func collectForecasts(resort Resort, chResorts chan Resort) {
    var fr ForecastResponse

    resp, err := http.Get(forecastUrl(resort.Lat, resort.Lon))
    defer resp.Body.Close()

    if err != nil {
        panic(err)
    }

    body, err := ioutil.ReadAll(resp.Body)

    if err != nil {
        panic(err)
    }

    err = json.Unmarshal(body, &fr)
    if err != nil {
        panic(err)
    }

    // TODO: Need to format forecast, massage response to be the keys we want for DB...
    resort.Forecasts = fr.Daily.Data
    chResorts <- resort
}

func allResorts() []Resort {
    var resorts []Resort

    rows, err := db.Query(`SELECT id, uid, lat, lon FROM resorts;`)
    defer rows.Close()
	if err != nil {
        log.Fatal(err)
	}

    for rows.Next() {
        resort := new(Resort)
        err := rows.Scan(&resort.Id, &resort.Uid, &resort.Lat, &resort.Lon)
        if err != nil {
            panic(err)
        }
        resorts = append(resorts, *resort)
    }

    return resorts
}

func pctToInt(pct float64) int {
    return int(pct * 100)
}

func forecastUrl(lat float64, lon float64) string {
    queryParams := fmt.Sprintf("exclude=currently,minutely,hourly,flags")
    url := fmt.Sprintf("%s/forecast/%s/%g,%g?%s", darkSkyUrl, darkSkyApiKey, lat, lon, queryParams)

    return url
}

func loadApiKey() {
    err := godotenv.Load()
    if err != nil {
        log.Fatal("Error loading .env file")
    }

    darkSkyApiKey = os.Getenv("DARK_SKY_API_KEY")
}

func connectToDB() *sql.DB {
  psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
    "dbname=%s sslmode=disable",
    dbHost, dbPort, dbUser, dbName)


    db, err := sql.Open("postgres", psqlInfo)
    if err != nil {
      panic(err)
    }

    err = db.Ping()
    if err != nil {
      panic(err)
    }

    fmt.Println("Successfully connected!")

    return db
}
