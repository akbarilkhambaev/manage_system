# Docker Build & Push Script

# Сборка образов локально
docker build -f Dockerfile.backend -t akbarilkhambaev/paint-backend:latest .
docker build -f Dockerfile.frontend -t akbarilkhambaev/paint-frontend:latest .

# Пуш в Docker Hub (нужен docker login)
docker push akbarilkhambaev/paint-backend:latest
docker push akbarilkhambaev/paint-frontend:latest

# Использовать в Railway:
# Backend: akbarilkhambaev/paint-backend:latest
# Frontend: akbarilkhambaev/paint-frontend:latest