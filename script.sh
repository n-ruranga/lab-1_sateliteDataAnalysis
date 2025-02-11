#!/bin/bash

# Define the input file
DATA_FILE="./raw_data/satelite_temperature_data.csv"
OUTPUT_DIR="analyzed_data"
HIGHEST_TEMP_FILE="$OUTPUT_DIR/highest_temp.csv"

# Check if the data file exists
if [ ! -f "$DATA_FILE" ]; then
    echo "Error: Data file $DATA_FILE not found!"
    exit 1
fi

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Check if highest_temp.csv exists before creating it again
if [ -f "$HIGHEST_TEMP_FILE" ]; then
    read -p "File $HIGHEST_TEMP_FILE already exists. Overwrite? (y/n): " OVERWRITE
    if [ "$OVERWRITE" != "y" ]; then
        echo "Skipping highest temperature extraction."
    else
        echo "Extracting the top 10 highest temperatures..."
        tail -n +2 "$DATA_FILE" | sort -t, -k3,3nr | head -n 10 > "$HIGHEST_TEMP_FILE"
        echo "Highest temperature data saved in $HIGHEST_TEMP_FILE"
    fi
else
    echo "Extracting the top 10 highest temperatures..."
    tail -n +2 "$DATA_FILE" | sort -t, -k3,3nr | head -n 10 > "$HIGHEST_TEMP_FILE"
    echo "Highest temperature data saved in $HIGHEST_TEMP_FILE"
fi

# Prompt user for country input
read -p "Enter a country name to extract humidity data: " COUNTRY

# Validate input
if [ -z "$COUNTRY" ]; then
    echo "Error: No country entered. Exiting."
    exit 1
fi

# Extract humidity data for the entered country
OUTPUT_FILE="$OUTPUT_DIR/humidity_data_${COUNTRY}.csv"
echo "Extracting humidity data for $COUNTRY..."
awk -F, -v country="$COUNTRY" '$1 == country' "$DATA_FILE" | sort -t, -k4,4nr > "$OUTPUT_FILE"

# Check if data was written
if [ -s "$OUTPUT_FILE" ]; then
    echo "Humidity data for $COUNTRY saved in $OUTPUT_FILE"
else
    echo "No data found for $COUNTRY. File is empty."
fi

echo "Script execution completed."
echo "=================================================="
