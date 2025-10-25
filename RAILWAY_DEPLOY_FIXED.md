# 🚀 Railway Deployment Guide - ИСПРАВЛЕННАЯ ВЕРСИЯ

## Инструкция по деплою Paint Management System на Railway

### 🚨 Решение проблемы "Railpack could not determine how to build the app"

Проблема возникает потому, что у нас монорепозиторий. Railway нужно указать, где искать каждое приложение.

### 📋 Правильный способ деплоя

#### 🔧 Backend Service (Django)

1. **Создание сервиса:**
   - Railway Dashboard → **New Service** → **GitHub Repo**
   - Выберите репозиторий `manage_system`

2. **Настройка Source (ВАЖНО!):**
   - **Settings** → **Source** → **Root Directory**: `backend`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `bash deploy.sh`

3. **Переменные окружения:**
   ```
   SECRET_KEY=your-super-secret-key-here-change-this
   DEBUG=False
   DATABASE_URL=mysql://root:ZPSlrmSKgYSbbKsvSMwHMjVeZEqtBrBT@gondola.proxy.rlwy.net:55502/railway
   PORT=8000
   ```

#### 🎨 Frontend Service (Next.js)

1. **Создание сервиса:**
   - В том же проекте: **+ New Service** → **GitHub Repo**
   - Выберите тот же репозиторий `manage_system`

2. **Настройка Source (ВАЖНО!):**
   - **Settings** → **Source** → **Root Directory**: `frontend`
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm start`

3. **Переменные окружения:**
   ```
   NEXT_PUBLIC_API_URL=https://your-backend-service-name.railway.app
   NODE_ENV=production
   ```

### 🔍 Если Railway всё ещё не распознаёт приложения:

#### Вариант А: Используйте конфигурационные файлы

Уже созданы файлы:
- `backend/nixpacks.toml` - для Django
- `frontend/nixpacks.toml` - для Next.js
- `backend/railway.toml` - альтернативная конфигурация
- `frontend/railway.toml` - альтернативная конфигурация

#### Вариант Б: Ручная настройка в Railway

1. **Settings** → **Build**:
   - **Builder**: NIXPACKS
   - **Build Command**: указать вручную
   - **Start Command**: указать вручную

2. **Settings** → **Deploy**:
   - **Custom Start Command**: включить

### 🎯 Пошаговый алгоритм деплоя:

1. **Коммитьте все изменения:**
   ```bash
   git add .
   git commit -m "Add Railway deployment configs"
   git push origin main
   ```

2. **Создайте Backend сервис:**
   - New Service → GitHub → выберите репозиторий
   - **Root Directory**: `backend`
   - Дождитесь деплоя
   - Скопируйте URL

3. **Создайте Frontend сервис:**
   - New Service → GitHub → тот же репозиторий
   - **Root Directory**: `frontend`
   - **Variables**: `NEXT_PUBLIC_API_URL=URL_от_backend`
   - Дождитесь деплоя

### 🔧 Troubleshooting

**Проблема: "Could not determine how to build"**
- ✅ Убедитесь, что указали **Root Directory**
- ✅ Проверьте наличие `requirements.txt` в `backend/`
- ✅ Проверьте наличие `package.json` в `frontend/`

**Проблема: "Build failed"**
- Проверьте логи сборки
- Убедитесь в правильности команд сборки
- Проверьте зависимости

**Проблема: "Service не запускается"**
- Проверьте переменные окружения
- Убедитесь в правильности Start Command
- Проверьте логи выполнения

### 📊 База данных

MySQL уже настроена! При деплое Backend:
1. Автоматически выполнятся миграции
2. Создастся суперпользователь (admin/admin123)
3. Настроятся все таблицы

### 🌐 Финальные URL'ы

После успешного деплоя:
- **Backend API**: `https://your-backend.railway.app/api/`
- **Frontend**: `https://your-frontend.railway.app`
- **Django Admin**: `https://your-backend.railway.app/admin/`

### 💡 Полезные советы

1. **Используйте одинаковые названия** для сервисов (например: `paint-backend`, `paint-frontend`)
2. **Проверьте CORS настройки** в Django после получения Frontend URL
3. **Мониторьте логи** во время первого деплоя
4. **Тестируйте API endpoints** после деплоя Backend

---

✅ **Проблема "Railpack could not determine" решена!** Главное - указать правильный Root Directory для каждого сервиса.