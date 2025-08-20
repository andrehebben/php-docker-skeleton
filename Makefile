up:    ; docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d app
down:  ; docker compose -f docker-compose.yml -f docker-compose.dev.yml down
sh:    ; docker compose -f docker-compose.yml -f docker-compose.dev.yml exec app sh
ci:    ; docker compose -f docker-compose.yml -f docker-compose.dev.yml exec app composer lint && docker compose -f docker-compose.yml -f docker-compose.dev.yml exec app composer stan && docker compose -f docker-compose.yml -f docker-compose.dev.yml exec app composer test
test:  ; docker compose -f docker-compose.yml -f docker-compose.dev.yml exec app composer test
