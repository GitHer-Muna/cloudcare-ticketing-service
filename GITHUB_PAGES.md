# GitHub Pages Setup

Deploy frontend to GitHub Pages.

---

## Important

GitHub Pages only hosts **static sites** (frontend only).

You still need to deploy the backend separately (Render/Railway).

---

## Quick Deploy

```bash
# Install gh-pages
cd frontend
npm install --save-dev gh-pages

# Build and deploy
npm run build
npx gh-pages -d dist
cd ..
```

---

## Enable in GitHub

1. Go to: https://github.com/GitHer-Muna/cloudcare-ticketing-service/settings/pages
2. Source: "Deploy from a branch"
3. Branch: `gh-pages`
4. Folder: `/ (root)`
5. Save

Wait 2-3 minutes.

---

## Live URL

Frontend: https://GitHer-Muna.github.io/cloudcare-ticketing-service

---

## Update Backend URL

After deploying backend to Render:

1. Edit `frontend/.env.production`:
```
VITE_API_URL=https://your-backend.onrender.com/api/v1
```

2. Redeploy:
```bash
cd frontend && npm run deploy
```

---

## Auto-Deploy with GitHub Actions

Already configured in `.github/workflows/deploy.yml`

Every push to `main` auto-deploys frontend.

---

Done! Frontend is live.
