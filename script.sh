#Command to Obtain highest temperatures
tail -n +2 ./raw_data/satelite_temperature_data.csv | sort -t, -k3,3nr | head -n 10 > analyzed_data/highest_temp.csv
#Comand to capture the data of a single country which is Rwanda
awk -F, '$1 == "Rwanda"' raw_data/satelite_temperature_data.csv | sort -t, -k4,4nr > analyzed_data/humidity_data_Rwanda.csv
