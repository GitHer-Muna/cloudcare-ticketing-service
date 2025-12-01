#!/bin/bash

echo "🚀 CloudCare - Quick Push to GitHub"
echo "===================================="
echo ""

# Add all files
echo "📦 Adding files..."
git add .

# Show what will be committed
echo ""
echo "Files to be committed:"
git status --short

echo ""
read -p "Continue with commit? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "❌ Aborted"
    exit 1
fi

# Commit with comprehensive message
echo ""
echo "📝 Committing..."
git commit -m "Production-ready CloudCare Customer Support Ticketing System

✨ Features:
- Complete REST API with TypeScript, Express.js, PostgreSQL
- Full authentication system (JWT with refresh tokens)
- Role-Based Access Control (Admin, Agent, User)
- Complete ticket management (CRUD, comments, assignments)
- Advanced filtering, search, and pagination
- Real-time statistics and dashboard
- Security features (rate limiting, helmet, CORS, validation)
- Monitoring ready (health checks, Prometheus metrics)
- Audit logging for compliance

🎨 Frontend:
- Modern React 18 with TypeScript
- Tailwind CSS for styling
- Vite for fast development
- Zustand state management
- Protected routes with RBAC
- Responsive design

✅ Testing:
- Comprehensive test suite (20 tests)
- Manual testing verified
- All CRUD operations working
- Authentication & authorization tested
- Role-based permissions validated

📚 Documentation:
- Complete README with setup instructions
- Deployment guide (Render, Vercel, Netlify)
- API documentation
- Pre-push checklist
- Test accounts included

🚀 Deployment Ready:
- Environment configuration for production
- Database migrations with Prisma
- Seed data for quick start
- Rate limiting configured
- CORS configured
- Production build tested

🎯 Perfect for:
- DevOps learning and demonstrations
- CI/CD pipeline examples
- Kubernetes deployments
- Cloud infrastructure projects
- Blog posts and tutorials

Test Accounts:
- Admin: admin@cloudcare.com / Admin@123
- Agent: agent@cloudcare.com / Agent@123  
- User: user@cloudcare.com / User@123"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Committed successfully!"
    echo ""
    echo "📤 Pushing to GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "===================================="
        echo "🎉 Successfully pushed to GitHub!"
        echo "===================================="
        echo ""
        echo "Next steps:"
        echo "1. Deploy backend to Render: https://render.com"
        echo "2. Deploy frontend to Vercel: https://vercel.com"
        echo "3. See DEPLOYMENT_GUIDE.md for details"
        echo ""
    else
        echo ""
        echo "❌ Push failed. Check your GitHub connection."
        exit 1
    fi
else
    echo ""
    echo "❌ Commit failed"
    exit 1
fi
