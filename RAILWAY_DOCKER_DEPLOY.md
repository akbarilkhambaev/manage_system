# 🐳 Railway Deployment via Docker Images

## Преимущества Docker деплоя

✅ **Предсказуемость** - одинаковое окружение везде  
✅ **Надежность** - изолированные контейнеры  
✅ **Масштабируемость** - легко клонировать  
✅ **Версионность** - легко откатиться к предыдущей версии  

## 🚀 Деплой на Railway через Docker

### Способ 1: Автоматическая сборка (РЕКОМЕНДУЕТСЯ)

Railway автоматически обнаружит Dockerfile'ы и соберет образы.

#### Backend Service:
1. **New Service** → **GitHub Repo** → выберите `manage_system`
2. **Settings** → **Source**:
   - **Root Directory**: оставить пустым `/`
   - **Dockerfile Path**: `Dockerfile.backend`
3. **Variables**:
   ```
   SECRET_KEY=your-production-secret-key-here
   DEBUG=False
   DATABASE_URL=mysql://root:ZPSlrmSKgYSbbKsvSMwHMjVeZEqtBrBT@gondola.proxy.rlwy.net:55502/railway
   PORT=8000
   ```

#### Frontend Service:
1. **New Service** → **GitHub Repo** → тот же репозиторий
2. **Settings** → **Source**:
   - **Root Directory**: оставить пустым `/`
   - **Dockerfile Path**: `Dockerfile.frontend`
3. **Variables**:
   ```
   NEXT_PUBLIC_API_URL=https://your-backend-service.railway.app
   NODE_ENV=production
   PORT=3000
   ```

### Способ 2: Собранные образы через GitHub Actions

#### 1. Создаем GitHub Actions для сборки образов

Создайте `.github/workflows/docker-build.yml`:

```yaml
name: Build and Deploy Docker Images

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-backend:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2
    
    - name: Login to GitHub Container Registry
      uses: docker/login-action@v2
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}
    
    - name: Build and push Backend
      uses: docker/build-push-action@v4
      with:
        context: .
        file: ./Dockerfile.backend
        push: true
        tags: ghcr.io/${{ github.repository }}/backend:latest

  build-frontend:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2
    
    - name: Login to GitHub Container Registry
      uses: docker/login-action@v2
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}
    
    - name: Build and push Frontend
      uses: docker/build-push-action@v4
      with:
        context: .
        file: ./Dockerfile.frontend
        push: true
        tags: ghcr.io/${{ github.repository }}/frontend:latest
```

#### 2. Деплой из готовых образов в Railway

1. **New Service** → **Docker Image**
2. **Image URL**: `ghcr.io/akbarilkhambaev/manage_system/backend:latest`
3. Настройте переменные окружения

## 🧪 Локальное тестирование Docker

### Сборка образов:
```bash
# Backend
docker build -f Dockerfile.backend -t paint-backend .

# Frontend  
docker build -f Dockerfile.frontend -t paint-frontend .
```

### Запуск контейнеров:
```bash
# Через docker-compose (рекомендуется)
docker-compose up --build

# Или отдельно:
docker run -p 8000:8000 paint-backend
docker run -p 3000:3000 paint-frontend
```

### Проверка health checks:
```bash
# Backend health
curl http://localhost:8000/api/

# Frontend health  
curl http://localhost:3000/
```

## 🔧 Настройки Docker для Railway

### Backend Dockerfile особенности:
- ✅ Multi-stage build для оптимизации размера
- ✅ Non-root user для безопасности  
- ✅ Health checks для мониторинга
- ✅ Proper signal handling
- ✅ MySQL драйвера включены

### Frontend Dockerfile особенности:
- ✅ Standalone output для производительности
- ✅ Static files optimization
- ✅ Security-first approach
- ✅ Health checks
- ✅ Minimal Alpine base

## 📊 Мониторинг Docker контейнеров

Railway автоматически предоставляет:
- **CPU/Memory metrics** 
- **Health check status**
- **Container logs**
- **Restart policies**

## 🚨 Troubleshooting

### Контейнер не запускается:
1. Проверьте логи сборки
2. Убедитесь в правильности Dockerfile syntax
3. Проверьте health check endpoints

### Большой размер образа:
1. Используйте .dockerignore
2. Multi-stage builds уже настроены  
3. Очистите кеши в Dockerfile

### Проблемы с подключением:
1. Проверьте CORS настройки
2. Убедитесь в правильности NEXT_PUBLIC_API_URL
3. Проверьте health checks

## 🎯 Результат

После деплоя через Docker вы получите:
- **Стабильные контейнеры** с предсказуемым поведением
- **Автоматический мониторинг** через health checks  
- **Быстрые откаты** к предыдущим версиям
- **Масштабируемость** без изменения кода

---

🐳 **Docker deployment = Production Ready!** 🚀