# CloudCare Deployment Guide

Complete guide for deploying CloudCare to production.

## 🚀 Quick Deploy (Free Tier)

**Recommended Stack:**
- Backend: Render.com (Free)
- Frontend: Vercel (Free)
- Database: Neon.tech PostgreSQL (Free)

**Total Cost: $0/month**

---

## Backend Deployment

### Deploy to Render.com

1. **Create Account**: Sign up at [render.com](https://render.com)

2. **Create PostgreSQL Database**:
   - Click "New +" → "PostgreSQL"
   - Name: `cloudcare-db`
   - Free tier selected
   - Click "Create Database"
   - Copy the **Internal Database URL**

3. **Deploy Backend**:
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Settings:
     ```
     Name: cloudcare-backend
     Environment: Node
     Build Command: npm install && npx prisma generate && npm run build
     Start Command: npm start
     ```

4. **Add Environment Variables**:
   ```bash
   NODE_ENV=production
   PORT=3000
   DATABASE_URL=<your-postgres-internal-url>
   JWT_SECRET=<generate-random-string-here>
   JWT_REFRESH_SECRET=<generate-random-string-here>
   CORS_ORIGIN=<your-frontend-url>
   ```

5. **Run Database Migrations**:
   - In Render dashboard, go to Shell tab
   - Run: `npm run db:migrate && npm run db:seed`

6. **Your backend is live!** 
   - URL: `https://cloudcare-backend.onrender.com`

---

### Alternative: Railway.app

1. **Create Account**: [railway.app](https://railway.app)
2. **New Project** → **Deploy from GitHub repo**
3. **Add PostgreSQL**: Click "+" → "Database" → "PostgreSQL"
4. **Configure**:
   - Add environment variables (same as above)
   - Build Command: `npm install && npx prisma generate && npm run build`
   - Start Command: `npm start`
5. **Deploy** and copy the generated URL

---

## Frontend Deployment

### Deploy to Vercel (Recommended)

1. **Create Account**: Sign up at [vercel.com](https://vercel.com)

2. **Import Project**:
   - Click "Add New" → "Project"
   - Import your GitHub repository
   - **Root Directory**: Set to `frontend`
   - **Framework Preset**: Vite

3. **Environment Variables**:
   ```bash
   VITE_API_URL=https://cloudcare-backend.onrender.com/api/v1
   ```

4. **Deploy**:
   - Click "Deploy"
   - Your frontend is live at `https://your-project.vercel.app`

5. **Update Backend CORS**:
   - Go back to Render backend settings
   - Update `CORS_ORIGIN` to your Vercel URL

---

### Alternative: Netlify

1. **Create Account**: [netlify.com](https://netlify.com)
2. **Import from Git**: Connect your repository
3. **Build Settings**:
   ```
   Base directory: frontend
   Build command: npm run build
   Publish directory: frontend/dist
   ```
4. **Environment Variables**: Add `VITE_API_URL`
5. **Deploy** and get your URL

---

## Database Options

### Option 1: Neon.tech (Recommended)

1. **Sign up**: [neon.tech](https://neon.tech)
2. **Create Project**: 
   - Project name: `cloudcare`
   - Region: Choose closest to your backend
3. **Get Connection String**:
   - Copy the connection string
   - Format: `postgresql://user:pass@host/dbname?sslmode=require`
4. **Use in Backend**: Set as `DATABASE_URL`

### Option 2: Supabase

1. **Sign up**: [supabase.com](https://supabase.com)
2. **New Project**: Create and get PostgreSQL connection string
3. **Use Connection String**: Settings → Database → Connection string

### Option 3: Render PostgreSQL

- Already included if deploying backend to Render
- Use the Internal Database URL for best performance

---

## Environment Configuration

### Backend `.env` (Production)

```bash
# Server
NODE_ENV=production
PORT=3000

# Database
DATABASE_URL=postgresql://user:pass@host:5432/cloudcare

# JWT Secrets (Generate with: openssl rand -base64 32)
JWT_SECRET=your-super-secret-jwt-key-here
JWT_REFRESH_SECRET=your-super-secret-refresh-key-here
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d

# CORS
CORS_ORIGIN=https://your-frontend.vercel.app

# API
API_PREFIX=/api/v1

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# Monitoring
ENABLE_METRICS=true
```

### Frontend `.env.production`

```bash
VITE_API_URL=https://your-backend.onrender.com/api/v1
```

---

## Post-Deployment Steps

### 1. Run Database Migrations

**On Render:**
```bash
# In Render Shell
npm run db:migrate
npm run db:seed
```

**On Railway:**
```bash
# In Railway CLI or Web Terminal
npm run db:migrate
npm run db:seed
```

### 2. Test Your Deployment

```bash
# Health Check
curl https://your-backend.onrender.com/api/v1/health

# Test Login
curl -X POST https://your-backend.onrender.com/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@cloudcare.com","password":"Admin123!@#"}'
```

### 3. Access Your Application

1. Open `https://your-frontend.vercel.app`
2. Login with seeded account:
   - Email: `admin@cloudcare.com`
   - Password: `Admin123!@#`

---

## Monitoring

### Health Checks

Your backend includes health check endpoints:
- **Health**: `GET /api/v1/health`
- **Metrics**: `GET /metrics` (Prometheus format)

### Render Monitoring

- Render provides built-in monitoring
- View logs, metrics, and alerts in dashboard

### External Monitoring (Optional)

- **UptimeRobot**: Free uptime monitoring
- **Better Uptime**: Status page and monitoring
- **Sentry**: Error tracking (free tier available)

---

## Scaling Considerations

### Free Tier Limitations

- **Render Free**: Spins down after 15 min inactivity (first request takes ~30s)
- **Neon Free**: 512 MB storage, 100 hours compute/month
- **Vercel Free**: Unlimited bandwidth, 100GB-hours

### Upgrade Paths

When you outgrow free tier:

1. **Backend**: Render Starter ($7/month) - Always on, 512MB RAM
2. **Database**: Neon Scale ($19/month) - More storage & compute
3. **Frontend**: Vercel Pro ($20/month) - More features

---

## CI/CD Setup

### GitHub Actions (Automatic Deployment)

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm install
      - run: npx prisma generate
      - run: npm run build
      # Render auto-deploys on push

  deploy-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: cd frontend && npm install
      - run: cd frontend && npm run build
      # Vercel auto-deploys on push
```

---

## Troubleshooting

### Backend Won't Start

1. Check logs in Render dashboard
2. Verify `DATABASE_URL` is correct
3. Ensure migrations ran: `npm run db:migrate`

### Frontend Can't Connect

1. Verify `VITE_API_URL` points to backend
2. Check backend `CORS_ORIGIN` includes frontend URL
3. Test backend health: `curl <backend-url>/api/v1/health`

### Database Connection Issues

1. Check connection string format
2. Ensure `?sslmode=require` for production databases
3. Verify database is running and accessible

---

## Security Checklist

- [ ] Changed default JWT secrets
- [ ] Updated admin password after deployment
- [ ] Enabled HTTPS (automatic with Vercel/Render)
- [ ] Set proper CORS origins
- [ ] Enabled rate limiting
- [ ] Database connections use SSL
- [ ] Environment variables secured (not in code)
- [ ] Logs don't expose sensitive data

---

## Cost Breakdown

### Free Tier (Good for learning/demos)
- Backend: $0 (Render Free)
- Frontend: $0 (Vercel)
- Database: $0 (Neon)
- **Total: $0/month**

### Production Ready
- Backend: $7 (Render Starter)
- Frontend: $0 (Vercel Hobby)
- Database: $19 (Neon Scale)
- **Total: $26/month**

### High Traffic
- Backend: $15-25 (Render Standard)
- Frontend: $20 (Vercel Pro)
- Database: $69+ (Neon Business)
- **Total: $104+/month**

---

## Additional Resources

- [Render Documentation](https://render.com/docs)
- [Vercel Documentation](https://vercel.com/docs)
- [Neon Documentation](https://neon.tech/docs)
- [Prisma Migrations](https://www.prisma.io/docs/concepts/components/prisma-migrate)

---

**Ready to deploy?** Start with the [Quick Deploy](#-quick-deploy-free-tier) section!
