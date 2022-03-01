# calorie-counter-backend
Backend for my calorie counter app for my thesis.

docker-compose up

docker exec -i cc-postgres psql -U postgres -d keycloak_db < ./keycloak_backup.sql
