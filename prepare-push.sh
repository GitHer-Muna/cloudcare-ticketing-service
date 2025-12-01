#!/bin/bash

echo "🚀 Preparing CloudCare for GitHub Push"
echo "======================================"
echo ""

# Step 1: Check TypeScript compilation
echo "1. Checking TypeScript compilation..."
npx tsc --noEmit
if [ $? -ne 0 ]; then
    echo "❌ TypeScript errors found. Fix them first."
    exit 1
fi
echo "✅ TypeScript check passed"
echo ""

# Step 2: Check frontend TypeScript
echo "2. Checking Frontend TypeScript..."
cd frontend && npx tsc --noEmit && cd ..
if [ $? -ne 0 ]; then
    echo "❌ Frontend TypeScript errors found. Fix them first."
    exit 1
fi
echo "✅ Frontend TypeScript check passed"
echo ""

# Step 3: Build backend
echo "3. Building backend..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Backend build failed"
    exit 1
fi
echo "✅ Backend build successful"
echo ""

# Step 4: Build frontend
echo "4. Building frontend..."
cd frontend && npm run build && cd ..
if [ $? -ne 0 ]; then
    echo "❌ Frontend build failed"
    exit 1
fi
echo "✅ Frontend build successful"
echo ""

# Step 5: Run tests
echo "5. Running full functionality tests..."
./test-full-functionality.sh
if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Fix issues first."
    exit 1
fi
echo "✅ All tests passed"
echo ""

# Step 6: Clean up temporary files
echo "6. Cleaning up temporary files..."
rm -f test-results.log
rm -f /tmp/ticket.json
echo "✅ Cleanup complete"
echo ""

# Step 7: Check git status
echo "7. Checking git status..."
git status
echo ""

# Step 8: Ready to commit
echo "======================================"
echo "✅ All checks passed!"
echo ""
echo "Ready to push to GitHub. Run:"
echo ""
echo "  git add ."
echo "  git commit -m \"Production-ready CloudCare ticketing system\""
echo "  git push origin main"
echo ""
echo "Or use the provided commit message in PRE_PUSH_CHECKLIST.md"
echo "======================================"
