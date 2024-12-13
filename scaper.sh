#!/bin/bash

DB_NAME="scraping_db"
DB_USER="user"
DB_TABLE="assets"
SITEMAP_URL="https://readi.fi/sitemap.xml"
TMP_FILE="urls.txt"

curl -s "$SITEMAP_URL" | grep -oP '(?<=<loc>).*?(?=</loc>)' | grep '^https://readi.fi/asset' | sort -u > "$TMP_FILE"

while IFS= read -r url; do
    echo "Traitement de : $url"
    content=$(curl -s "$url")
    title=$(echo "$content" | grep -oP '(?<=<title>).*?(?=</title>)')
    description=$(echo "$content" | grep -oP '(?<=<meta name="description" content=").*?(?=")')
    psql -d "$DB_NAME" -U "$DB_USER" -c "INSERT INTO $DB_TABLE (url, title, description) VALUES ('$url', '$title', '$description');"
done < "$TMP_FILE"

rm "$TMP_FILE"
