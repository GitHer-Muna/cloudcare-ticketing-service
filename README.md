# CloudCare - Customer Support Ticketing System

A production-ready full-stack ticketing system built for DevOps learning and demonstrations.

[![Live Demo](https://img.shields.io/badge/demo-live-success)](https://GitHer-Muna.github.io/cloudcare-ticketing-service)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-18-blue)](https://reactjs.org/)

---

## What is CloudCare?

A complete enterprise-grade ticketing system with authentication, role-based access control, and full CRUD operations. Perfect for learning CI/CD, containerization, and cloud deployments.

**Why this project?**
- Real production patterns, not toy examples
- Full-stack implementation with modern tech
- Ready for Docker, Kubernetes, and cloud deployment
- Comprehensive API and clean architecture

---

## Tech Stack

**Backend:**
- Node.js 18 + TypeScript
- Express.js REST API
- PostgreSQL + Prisma ORM
- JWT Authentication

**Frontend:**
- React 18 + TypeScript
- Tailwind CSS
- Vite
- Zustand (state management)

---

## Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL 16+

### Setup

```bash
# 1. Install dependencies
npm install
cd frontend && npm install && cd ..

# 2. Configure database
createdb cloudcare_ticketing

# 3. Setup environment (update .env with your database URL)
DATABASE_URL="postgresql://postgres:password@localhost:5432/cloudcare_ticketing"

# 4. Run migrations and seed data
npm run db:migrate
npm run db:seed

# 5. Start backend (terminal 1)
npm run dev

# 6. Start frontend (terminal 2)
cd frontend && npm run dev
```

**Access:** http://localhost:5173

---

## Test Accounts

| Role  | Email                 | Password  |
|-------|-----------------------|-----------|
| Admin | admin@cloudcare.com   | Admin@123 |
| Agent | agent@cloudcare.com   | Agent@123 |
| User  | user@cloudcare.com    | User@123  |

---

## Features

**Core:**
- User authentication (JWT with refresh tokens)
- Role-based access (Admin/Agent/User)
- Ticket management (create, read, update, delete)
- Comments system (public & internal)
- Ticket assignment and status tracking
- Advanced filtering and search

**Security:**
- Password hashing (bcrypt)
- Rate limiting
- CORS protection
- Input validation
- SQL injection prevention

**DevOps Ready:**
- Health check endpoints
- Prometheus metrics
- Structured logging
- Environment-based config
- Database migrations

---

## API Endpoints

```
POST   /api/v1/auth/register       Register new user
POST   /api/v1/auth/login          Login
POST   /api/v1/auth/logout         Logout
POST   /api/v1/auth/refresh        Refresh token

GET    /api/v1/tickets             List tickets
POST   /api/v1/tickets             Create ticket
GET    /api/v1/tickets/:id         Get ticket
PATCH  /api/v1/tickets/:id         Update ticket
DELETE /api/v1/tickets/:id         Delete ticket
POST   /api/v1/tickets/:id/comments Add comment
GET    /api/v1/tickets/stats       Get statistics

GET    /api/v1/health              Health check
GET    /metrics                    Prometheus metrics
```

Full API docs: [docs/API.md](docs/API.md)

---

## Testing

Run comprehensive test suite (20 tests):

```bash
./test-full-functionality.sh
```

Tests cover:
- Authentication flows
- CRUD operations
- Role-based permissions
- Comments and assignments
- Search and filtering

---

## Deployment

**Frontend:** GitHub Pages (deployed)
- Live: https://GitHer-Muna.github.io/cloudcare-ticketing-service

**Backend:** Deploy to Render/Railway/Heroku
- See [DEPLOY.md](DEPLOY.md) for step-by-step instructions
- Free tier options available

**Database:** Neon.tech or Supabase PostgreSQL (free tier)

---

## Project Structure

```
├── src/                    # Backend source
│   ├── controllers/        # Route handlers
│   ├── services/          # Business logic
│   ├── routes/            # API routes
│   ├── middleware/        # Express middleware
│   └── database/          # Prisma client & seeds
├── frontend/              # React frontend
│   └── src/
│       ├── components/    # UI components
│       ├── pages/         # Page components
│       ├── store/         # State management
│       └── lib/           # API client
├── prisma/               # Database schema
└── docs/                 # Documentation
```

---

## Common Commands

```bash
# Backend
npm run dev              # Start dev server
npm run build            # Build for production
npm start                # Start production
npm run db:migrate       # Run migrations
npm run db:seed          # Seed database

# Frontend
cd frontend
npm run dev              # Start dev server
npm run build            # Build for production
npm run deploy           # Deploy to GitHub Pages

# Testing
./test-full-functionality.sh    # Run all tests
```

---

## Use Cases for DevOps

This project demonstrates:

1. **Containerization** - Add Docker/docker-compose
2. **CI/CD** - GitHub Actions, GitLab CI, Jenkins
3. **Kubernetes** - Deploy with K8s manifests/Helm
4. **Infrastructure as Code** - Terraform, Pulumi
5. **Monitoring** - Prometheus + Grafana dashboards
6. **Cloud Deployment** - AWS, GCP, Azure
7. **Security Scanning** - SAST/DAST integration
8. **Load Testing** - Performance benchmarking

---

## Documentation

- [DEPLOY.md](DEPLOY.md) - Deploy to production
- [GITHUB_PAGES.md](GITHUB_PAGES.md) - GitHub Pages setup
- [CHECKLIST.md](CHECKLIST.md) - Pre-push checklist
- [docs/API.md](docs/API.md) - Complete API reference

---

## License

MIT License - Free to use for learning and portfolio projects.

---

## Author

Built for aspiring DevOps engineers who want real-world applications to practice deployment, monitoring, and infrastructure automation.

**Questions?** Open an issue or check the deployment guides.
