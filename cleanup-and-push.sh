#!/bin/bash

# CloudCare - Cleanup unnecessary files and push to GitHub
echo "🧹 Cleaning up unnecessary files..."

# Remove duplicate/old documentation files
rm -f DEPLOYMENT_GUIDE.md
rm -f GITHUB_PAGES_DEPLOYMENT.md
rm -f PRE_PUSH_CHECKLIST.md
rm -f READY_TO_PUSH.md
rm -f prepare-push.sh
rm -f quick-push.sh

echo "✅ Removed duplicate files"

# Check git status
echo ""
echo "📊 Git status:"
git status --short

# Add all changes
echo ""
echo "➕ Adding changes to git..."
git add .

# Commit
echo ""
echo "💾 Committing changes..."
git commit -m "Clean repo - remove duplicate docs, keep only essential files

- Removed: DEPLOYMENT_GUIDE.md (duplicate of DEPLOY.md)
- Removed: GITHUB_PAGES_DEPLOYMENT.md (duplicate of GITHUB_PAGES.md)  
- Removed: PRE_PUSH_CHECKLIST.md (duplicate of CHECKLIST.md)
- Removed: READY_TO_PUSH.md (temporary file)
- Removed: prepare-push.sh, quick-push.sh (not needed)
- Updated: README.md with correct doc links
- Updated: .gitignore to prevent future duplicates

Essential docs kept:
- README.md (main documentation)
- DEPLOY.md (deployment guide)
- GITHUB_PAGES.md (GitHub Pages setup)
- CHECKLIST.md (pre-push checklist)
- docs/API.md (API reference)"

# Push to GitHub
echo ""
echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "✅ Done! Repository is clean and pushed to GitHub"
echo ""
echo "📁 Essential files in repo:"
echo "   - README.md (main docs)"
echo "   - DEPLOY.md (deployment)"
echo "   - GITHUB_PAGES.md (GitHub Pages)"
echo "   - CHECKLIST.md (pre-push checklist)"
echo "   - docs/API.md (API reference)"
echo "   - test-full-functionality.sh (tests)"
