tail -n +2 ./raw_data/satelite_temperature_data.csv | sort -t, -k3,3nr | head -n 10 > analyzed_data/highest_temp.csv
