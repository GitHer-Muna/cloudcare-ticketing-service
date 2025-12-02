# Pre-Push Checklist

Quick validation before pushing to GitHub.

---

## Run Automated Check

```bash
chmod +x prepare-push.sh
./prepare-push.sh
```

This checks: TypeScript, builds, and runs all 20 tests.

---

## Manual Verification

### Test Credentials
- Admin: `admin@cloudcare.com` / `Admin@123`
- Agent: `agent@cloudcare.com` / `Agent@123`
- User: `user@cloudcare.com` / `User@123`

### Browser Test
1. Login as Admin → Create ticket → Add comment → Logout
2. Login as Agent → View tickets → Assign ticket → Logout
3. Login as User → Create ticket → Logout

### API Test
```bash
./test-full-functionality.sh
```
Expected: All 20 tests pass ✓

---

## Git Push

```bash
git add .
git commit -m "Your message"
git push origin main
```

---

## After Push

1. Deploy backend to Render (see DEPLOY.md)
2. Update frontend .env.production
3. Redeploy frontend: `cd frontend && npm run deploy`

---

Done!
