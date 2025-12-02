# Deployment Guide

Deploy CloudCare to production for free in 15 minutes.

---

## Quick Deploy (Free)

**Stack:**
- Frontend: GitHub Pages ✓ (deployed)
- Backend: Render.com
- Database: Neon.tech

**Cost: $0/month**

---

## Step 1: Database (Neon.tech)

1. Sign up: [neon.tech](https://neon.tech)
2. Create project: `cloudcare`
3. Copy connection string

---

## Step 2: Backend (Render.com)

1. Sign up: [render.com](https://render.com)
2. New Web Service → Connect GitHub
3. Settings:
   - Build: `npm install && npx prisma generate && npm run build`
   - Start: `npm start`

4. Environment variables:
```
NODE_ENV=production
DATABASE_URL=<neon-connection-string>
JWT_SECRET=<random-32-chars>
JWT_REFRESH_SECRET=<random-32-chars>
CORS_ORIGIN=https://GitHer-Muna.github.io
```

5. Deploy → Wait 5 minutes
6. Shell tab: Run migrations
```bash
npm run db:migrate
npm run db:seed
```

Backend URL: `https://cloudcare-backend.onrender.com`

---

## Step 3: Update Frontend

1. Edit `frontend/.env.production`:
```
VITE_API_URL=https://cloudcare-backend.onrender.com/api/v1
```

2. Redeploy:
```bash
cd frontend && npm run deploy
```

---

## Test

Visit: https://GitHer-Muna.github.io/cloudcare-ticketing-service

Login: `admin@cloudcare.com` / `Admin@123`

---

## Troubleshooting

**Backend won't start:** Check logs, verify DATABASE_URL

**Frontend can't connect:** Verify VITE_API_URL and CORS_ORIGIN

**Database error:** Ensure connection string has `?sslmode=require`

---

## Alternative: Railway

Same process at [railway.app](https://railway.app)

---

Done! App is live at zero cost.
