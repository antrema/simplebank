package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	"antrema.com/golang_014_011/util"
	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	var err error

	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("cannot load configuration:", err)
	}

	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(testDB)

	os.Exit(m.Run())
}
