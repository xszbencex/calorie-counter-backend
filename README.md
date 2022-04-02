# calorie-counter-backend
Backend for my calorie counter app for my thesis.

mvn clean install

docker build -t calorie-counter-backend .

docker-compose -p calorie-counter up -d

docker-compose -p calorie-counter up -d postgres

docker-compose -p calorie-counter up -d keycloak

docker exec -i cc-postgres psql -U postgres -d keycloak_db < ./keycloak_backup.sql
