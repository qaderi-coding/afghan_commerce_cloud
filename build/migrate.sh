docker-compose up -d
for file in /migrations/*.sql; do
  echo "Applying $file..."
  docker exec -i afcc_postgres psql -U admin -d afghan_commerce < "$file"
done
