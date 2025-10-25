# 🚀 Railway Deployment Guide

## Инструкция по деплою Paint Management System на Railway

### 📋 Предварительные требования

1. Аккаунт на [Railway](https://railway.app/)
2. GitHub репозиторий с кодом
3. Настроенные Dockerfile'ы (уже готовы)

### 🔧 Настройка Backend (Django)

#### 1. Создание Backend сервиса на Railway

1. Зайдите на [Railway](https://railway.app/)
2. Нажмите **"New Project"**
3. Выберите **"Deploy from GitHub repo"**
4. Выберите репозиторий `manage_system`
5. Railway автоматически обнаружит Django

#### 2. Настройка переменных окружения для Backend

В разделе **Variables** добавьте:

```
SECRET_KEY=your-super-secret-key-here-change-this-in-production
DEBUG=False
DATABASE_URL=mysql://root:ZPSlrmSKgYSbbKsvSMwHMjVeZEqtBrBT@gondola.proxy.rlwy.net:55502/railway
PYTHONPATH=/app
DJANGO_SETTINGS_MODULE=paint_management.settings
PORT=8000
```

**⚠️ Важно**: Сгенерируйте новый SECRET_KEY для продакшена!

#### 3. Настройка деплоя Backend

В разделе **Settings**:
- **Build Command**: `pip install -r requirements.txt`
- **Start Command**: `bash deploy.sh`
- **Root Directory**: `backend`

**Примечание**: Скрипт `deploy.sh` автоматически:
- Выполнит миграции базы данных
- Создаст суперпользователя (admin/admin123)
- Соберет статические файлы
- Запустит сервер

### 🎨 Настройка Frontend (Next.js)

#### 1. Создание Frontend сервиса

1. В том же проекте нажмите **"+ New Service"**
2. Выберите **"GitHub Repo"**
3. Выберите тот же репозиторий
4. Railway обнаружит Next.js

#### 2. Настройка переменных окружения для Frontend

```
NEXT_PUBLIC_API_URL=https://your-backend-url.railway.app
NODE_ENV=production
```

#### 3. Настройка деплоя Frontend

В разделе **Settings**:
- **Build Command**: `npm install && npm run build`
- **Start Command**: `npm start`
- **Root Directory**: `frontend`

### 🔗 Настройка связи между сервисами

1. **Получите URL Backend'а** из Railway dashboard
2. **Обновите Frontend переменные**:
   ```
   NEXT_PUBLIC_API_URL=https://your-backend-railway-url.railway.app
   ```

### 📊 База данных

**MySQL уже настроена!** 🎉

Ваш проект настроен для использования MySQL базы данных Railway:
```
mysql://root:ZPSlrmSKgYSbbKsvSMwHMjVeZEqtBrBT@gondola.proxy.rlwy.net:55502/railway
```

При деплое произойдет:
1. Автоматические миграции
2. Создание суперпользователя (admin/admin123)
3. Настройка всех необходимых таблиц

**Локальная разработка**: По-прежнему использует SQLite для удобства.

### 🚀 Процесс деплоя

1. **Коммит изменений**:
   ```bash
   git add .
   git commit -m "Add Railway deployment configuration"
   git push origin main
   ```

2. **Railway автоматически задеплоит** при push'е в main ветку

### 🔍 Мониторинг

- **Логи**: Railway Dashboard > Service > Logs
- **Metrics**: Railway Dashboard > Service > Metrics
- **Health**: Проверьте статус сервисов

### 🛠️ Troubleshooting

#### Backend не запускается:
- Проверьте переменные окружения
- Проверьте логи миграций
- Убедитесь в правильности requirements.txt

#### Frontend не подключается к Backend:
- Проверьте NEXT_PUBLIC_API_URL
- Убедитесь в CORS настройках Django
- Проверьте логи Network в браузере

#### CORS ошибки:
Добавьте в Django settings.py:
```python
CORS_ALLOWED_ORIGINS = [
    "https://your-frontend-url.railway.app",
]
```

### 🌐 Кастомные домены

1. Railway Dashboard > Service > Settings
2. **Custom Domain** > Add Domain
3. Настройте DNS записи

### 💡 Советы по оптимизации

1. **Используйте PostgreSQL** вместо SQLite
2. **Настройте Static Files** для Django
3. **Включите Gzip** сжатие
4. **Настройте CDN** для статики

---

После деплоя ваше приложение будет доступно по URL:
- **Frontend**: `https://your-frontend.railway.app`
- **Backend**: `https://your-backend.railway.app`
- **API**: `https://your-backend.railway.app/api/`