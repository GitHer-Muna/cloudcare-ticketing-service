# GitHub Pages Deployment Guide

## ⚠️ Important: GitHub Pages Limitation

**GitHub Pages only hosts static sites (frontend)**. For your full-stack app:
- ✅ Frontend → GitHub Pages
- ❌ Backend → Needs a server (Render/Railway/Heroku)

## 🚀 Complete Deployment Plan

### Option 1: Free Tier (Recommended)
- **Frontend**: GitHub Pages (Free)
- **Backend**: Render.com (Free)
- **Database**: Neon.tech (Free)
- **Total Cost**: $0/month

### Option 2: All Vercel/Netlify
- **Frontend**: Vercel (Free)
- **Backend**: Vercel Serverless (Free tier)
- **Database**: Vercel Postgres (Free tier)

---

## 📦 Deploy Frontend to GitHub Pages

### Step 1: Install gh-pages

```bash
cd frontend
npm install --save-dev gh-pages
cd ..
```

### Step 2: Configure GitHub Repository

1. Go to your GitHub repo: https://github.com/GitHer-Muna/cloudcare-ticketing-service
2. Settings → Pages
3. Source: Deploy from a branch
4. Branch: Select `gh-pages` → `/ (root)` → Save

### Step 3: Deploy Backend First (REQUIRED)

**The frontend needs a backend API URL!**

Deploy backend to Render.com:

1. Go to [render.com](https://render.com) and sign up
2. Click "New +" → "Web Service"
3. Connect your GitHub repo
4. Configure:
   ```
   Name: cloudcare-backend
   Root Directory: (leave blank)
   Environment: Node
   Build Command: npm install && npx prisma generate && npm run build
   Start Command: npm start
   ```
5. Add Environment Variables:
   ```
   NODE_ENV=production
   PORT=3000
   DATABASE_URL=<your-postgres-url>
   JWT_SECRET=<random-string>
   JWT_REFRESH_SECRET=<random-string>
   CORS_ORIGIN=https://GitHer-Muna.github.io
   ```
6. Add PostgreSQL database (in Render dashboard)
7. Deploy!
8. **Copy your backend URL**: `https://cloudcare-backend.onrender.com`

### Step 4: Update Frontend API URL

Create `frontend/.env.production`:

```bash
VITE_API_URL=https://cloudcare-backend.onrender.com/api/v1
```

### Step 5: Build and Deploy Frontend

```bash
cd frontend
npm run build
npx gh-pages -d dist
cd ..
```

### Step 6: Access Your App

- **Frontend**: https://GitHer-Muna.github.io/cloudcare-ticketing-service
- **Backend**: https://cloudcare-backend.onrender.com

---

## 🔧 Automated Deployment

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: |
        cd frontend
        npm install
    
    - name: Build
      run: |
        cd frontend
        npm run build
      env:
        VITE_API_URL: ${{ secrets.VITE_API_URL }}
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./frontend/dist
```

Then add secret in GitHub:
- Go to Settings → Secrets → Actions
- Add `VITE_API_URL` = your backend URL

---

## 🎯 Quick Deploy Commands

```bash
# 1. Deploy backend to Render (manual - see Step 3 above)

# 2. Update frontend environment
echo "VITE_API_URL=https://your-backend.onrender.com/api/v1" > frontend/.env.production

# 3. Install gh-pages
cd frontend && npm install --save-dev gh-pages && cd ..

# 4. Deploy frontend
cd frontend && npm run build && npx gh-pages -d dist && cd ..

# 5. Wait 2-3 minutes, then visit:
# https://GitHer-Muna.github.io/cloudcare-ticketing-service
```

---

## 🐛 Troubleshooting

### Frontend shows blank page
- Check browser console for errors
- Verify `VITE_API_URL` is correct
- Check GitHub Pages is enabled in repo settings

### Cannot connect to backend
- Verify backend is running on Render
- Check CORS_ORIGIN includes GitHub Pages URL
- Test backend health: `curl https://your-backend.onrender.com/api/v1/health`

### 404 on page refresh
- This is normal for SPAs on GitHub Pages
- Add `404.html` = copy of `index.html` in `public` folder

---

## 💰 Cost Comparison

### GitHub Pages + Render (Recommended)
- Frontend: **Free** (GitHub Pages)
- Backend: **Free** (Render - spins down after 15 min)
- Database: **Free** (Neon - 512 MB)
- **Total: $0/month**

### Vercel (All-in-one)
- Frontend: **Free**
- Backend: **Free** (Serverless)
- Database: **Free** (Vercel Postgres - 256 MB)
- **Total: $0/month**

### Production Ready
- Frontend: **$0** (GitHub Pages)
- Backend: **$7/month** (Render Starter - always on)
- Database: **$19/month** (Neon Scale)
- **Total: $26/month**

---

## 🎓 Alternative: Deploy Everything to Vercel

If you want everything in one place:

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel

# Follow prompts
# - Link to your GitHub repo
# - Set root directory to `frontend` for frontend
# - Create new project for backend separately
```

See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for Vercel instructions.

---

**Ready to deploy?** Start with deploying the backend to Render, then deploy frontend to GitHub Pages!
