# CloudCare - Customer Support Ticketing Microservice

[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue.svg)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)
[![React](https://img.shields.io/badge/React-18-blue.svg)](https://reactjs.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A production-ready, enterprise-grade customer support ticketing system built with modern DevOps principles. Perfect for learning and demonstrating real-world DevOps practices including CI/CD, containerization, monitoring, and cloud deployments.

## 🎯 Purpose

This application is designed for **aspiring DevOps engineers** who want to work with a real, industry-standard full-stack application. Unlike simple "hello world" demos, CloudCare provides:

- **Real-world complexity** - Multi-tier architecture, database relationships, authentication, authorization
- **Production patterns** - Error handling, logging, metrics, health checks, API documentation
- **DevOps-ready** - Designed to be containerized, deployed, monitored, and scaled
- **Complete features** - Not a toy app, but a functional ticketing system with CRUD, comments, attachments
- **Best practices** - Clean code, TypeScript, validation, security, testing structure

Use this as your foundation for DevOps blogs, tutorials, and hands-on projects!

## ✨ Features

### Backend Features
- 🔐 **Authentication & Authorization** - JWT with refresh tokens, role-based access control (RBAC)
- 🎫 **Ticket Management** - Full CRUD operations with advanced filtering and pagination
- 💬 **Comment System** - Rich commenting on tickets with real-time updates
- 📎 **File Attachments** - Support for ticket attachments
- 📊 **Dashboard Stats** - Real-time statistics and metrics
- 🔍 **Advanced Search** - Filter by status, priority, assignee, date range, tags
- 📝 **Audit Logging** - Track all changes for compliance
- 🚦 **Health Checks** - Kubernetes-ready health and readiness endpoints
- 📈 **Prometheus Metrics** - Built-in monitoring and observability
- 🛡️ **Security** - Helmet, CORS, rate limiting, input validation
- 📚 **API Documentation** - Comprehensive API docs included

### Frontend Features
- 🎨 **Modern UI** - React with Tailwind CSS
- 📱 **Responsive Design** - Works on desktop, tablet, and mobile
- 🔄 **State Management** - Zustand for efficient state handling
- 🔐 **Protected Routes** - Role-based route protection
- ⚡ **Fast Builds** - Vite for lightning-fast development
- 🎯 **TypeScript** - Type-safe frontend code

### DevOps Features
- 📦 **Production-Ready** - Environment configuration, logging, error handling
- 🔧 **Database Migrations** - Prisma ORM with migration management
- 🌱 **Seed Data** - Pre-populated test data for quick starts
- 📊 **Monitoring Ready** - Prometheus metrics endpoint
- 🚀 **CI/CD Ready** - Structured for automated deployments
- 🐳 **Container-Friendly** - Designed to be easily containerized
- ☁️ **Cloud-Native** - Follows 12-factor app principles

## 🏗️ Architecture

### Technology Stack

**Backend:**
- Node.js 18+ with TypeScript 5.3
- Express.js 4.18 for REST API
- PostgreSQL 16 with Prisma ORM 5.7
- JWT for authentication
- Winston for logging
- Prometheus client for metrics

**Frontend:**
- React 18 with TypeScript
- Vite 5.0 for build tooling
- Tailwind CSS 3.4 for styling
- Zustand 4.4 for state management
- Axios for API calls

### Project Structure

```
cloudcare-ticketing-service/
├── src/                      # Backend source code
│   ├── controllers/          # Request handlers
│   ├── services/             # Business logic
│   ├── routes/               # API routes
│   ├── middleware/           # Express middleware
│   ├── database/             # Database client and seeds
│   ├── utils/                # Utilities (logger, errors, helpers)
│   ├── validators/           # Input validation
│   ├── config/               # Configuration management
│   └── types/                # TypeScript types
├── frontend/                 # Frontend source code
│   ├── src/
│   │   ├── components/       # Reusable components
│   │   ├── pages/            # Page components
│   │   ├── store/            # State management (Zustand)
│   │   ├── lib/              # Utilities and API client
│   │   └── types/            # TypeScript types
│   └── public/               # Static assets
├── prisma/                   # Database schema and migrations
│   ├── schema.prisma         # Database schema
│   └── migrations/           # Migration files
├── docs/                     # Documentation
│   ├── API.md               # API documentation
│   └── DEPLOYMENT.md        # Original deployment docs
├── DEPLOYMENT_GUIDE.md      # Production deployment guide
├── test-full-functionality.sh # Comprehensive test script
└── README.md                # This file
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm
- PostgreSQL 16+ (running locally or accessible)
- Git

### Installation

1. **Clone or download the project:**
```bash
cd /path/to/cloudcare-ticketing-service
```

2. **Install dependencies:**
```bash
# Backend
npm install

# Frontend
cd frontend && npm install && cd ..
```

3. **Setup PostgreSQL database:**
```bash
# Create database
createdb cloudcare_ticketing

# Or using psql
psql -U postgres -c "CREATE DATABASE cloudcare_ticketing;"
```

4. **Configure environment:**

Update the `.env` file with your database credentials:
```bash
DATABASE_URL="postgresql://postgres:yourpassword@localhost:5432/cloudcare_ticketing"
```

5. **Initialize database:**
```bash
npm run db:generate  # Generate Prisma Client
npm run db:migrate   # Run migrations
npm run db:seed      # Seed test data
```

6. **Start the application:**

Backend (Terminal 1):
```bash
npm run dev
# Backend runs on http://localhost:3000
```

Frontend (Terminal 2):
```bash
cd frontend
npm run dev
# Frontend runs on http://localhost:5173
```

7. **Access the application:**

Open your browser to `http://localhost:5173` and login with:
- **Admin**: admin@cloudcare.com / Admin@123
- **Agent**: agent@cloudcare.com / Agent@123
- **User**: user@cloudcare.com / User@123

8. **Test full functionality:**

```bash
./test-full-functionality.sh
```

This runs 20 comprehensive tests covering all features.

## 🧪 Testing

### Automated Test Suite

Run the comprehensive test script to verify all functionality:

```bash
chmod +x test-full-functionality.sh
./test-full-functionality.sh
```

**20 Tests Cover:**
- ✓ Authentication (Login, Register, Logout)
- ✓ All 3 user roles (Admin, Agent, User)
- ✓ Ticket CRUD operations
- ✓ Comments (Public & Internal)
- ✓ Ticket assignment & status updates
- ✓ Role-Based Access Control (RBAC)
- ✓ Search & filtering
- ✓ Statistics/Dashboard
- ✓ User isolation & security

### Manual Testing

**Health Check:**
```bash
curl http://localhost:3000/api/v1/health
```

**Login Test:**
```bash
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@cloudcare.com","password":"Admin@123"}'
```

**Create Ticket:**
```bash
curl -X POST http://localhost:3000/api/v1/tickets \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"title":"Test","description":"Testing","priority":"HIGH"}'
```

## 📖 Documentation

- **[DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)** - Complete deployment guide (Render, Vercel, Railway, Netlify)
- **[docs/API.md](docs/API.md)** - Complete API documentation with examples
- **[test-full-functionality.sh](test-full-functionality.sh)** - Comprehensive test script (20 tests)

## 🚀 Quick Deploy to Production

### Free Tier Deployment (5 minutes)

1. **Deploy Backend to Render**:
   - Sign up at [render.com](https://render.com)
   - Create PostgreSQL database
   - Deploy from GitHub → Connect repo
   - Add environment variables (see [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md))

2. **Deploy Frontend to Vercel**:
   - Sign up at [vercel.com](https://vercel.com)
   - Import project → Set root to `frontend`
   - Add `VITE_API_URL` environment variable

3. **Done!** Your app is live at zero cost.

**Full deployment instructions**: [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

## 🔑 Test Accounts

After seeding the database, use these accounts:

| Role  | Email                 | Password   |
|-------|-----------------------|------------|
| Admin | admin@cloudcare.com   | Admin@123  |
| Agent | agent@cloudcare.com   | Agent@123  |
| User  | user@cloudcare.com    | User@123   |

## 🧪 API Endpoints

### Authentication
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - Login and get tokens
- `POST /api/v1/auth/refresh` - Refresh access token
- `POST /api/v1/auth/logout` - Logout and invalidate tokens

### Tickets
- `GET /api/v1/tickets` - List tickets (with filtering)
- `POST /api/v1/tickets` - Create ticket
- `GET /api/v1/tickets/:id` - Get ticket details
- `PATCH /api/v1/tickets/:id` - Update ticket
- `DELETE /api/v1/tickets/:id` - Delete ticket
- `POST /api/v1/tickets/:id/comments` - Add comment
- `GET /api/v1/tickets/stats` - Get statistics

### System
- `GET /api/v1/health` - Health check endpoint
- `GET /metrics` - Prometheus metrics

See [docs/API.md](docs/API.md) for complete API documentation with request/response examples.

## 🛠️ Development

### Common Commands

```bash
# Backend development
npm run dev              # Start with hot reload
npm run build            # Build for production
npm start                # Start production server
npm run lint             # Lint TypeScript code
npm run db:studio        # Open Prisma Studio (DB GUI)

# Frontend development
cd frontend
npm run dev              # Start dev server
npm run build            # Build for production
npm run preview          # Preview production build

# Database
npm run db:generate      # Generate Prisma Client
npm run db:migrate       # Run migrations
npm run db:seed          # Seed data
npx prisma studio        # Open Prisma Studio GUI
npx prisma migrate reset # Reset database (⚠️ deletes all data)

# Testing
./test-full-functionality.sh  # Run all 20 tests
```

## 📊 Database Schema

The application uses PostgreSQL with the following main entities:

- **Users** - System users with roles (USER, AGENT, ADMIN)
- **Tickets** - Support tickets with status, priority, and assignments
- **Comments** - Comments on tickets with user attribution
- **Attachments** - File attachments linked to tickets
- **AuditLogs** - Audit trail of all changes
- **RefreshTokens** - JWT refresh token management

## 🔐 Security Features

- Password hashing with bcrypt
- JWT access tokens (15min expiry)
- Refresh tokens (7 day expiry)
- Role-based access control (RBAC)
- Request validation and sanitization
- Rate limiting
- CORS protection
- Security headers (Helmet)
- SQL injection prevention (Prisma)
- XSS protection

## 📈 Monitoring & Observability

- **Health Checks** - `/api/v1/health` endpoint
- **Metrics** - `/metrics` endpoint (Prometheus format)
- **Logging** - Winston logger with levels
- **Error Tracking** - Structured error handling
- **Request Logging** - HTTP request/response logging

## 🐳 DevOps Use Cases

This application is perfect for demonstrating:

1. **Containerization** - Add Dockerfiles and docker-compose
2. **CI/CD Pipelines** - GitHub Actions, GitLab CI, Jenkins
3. **Kubernetes Deployment** - Create manifests, Helm charts
4. **Infrastructure as Code** - Terraform, CloudFormation, Pulumi
5. **Monitoring Setup** - Prometheus, Grafana, ELK Stack
6. **Cloud Deployments** - AWS, GCP, Azure
7. **Load Balancing** - Nginx, HAProxy, cloud load balancers
8. **Database Management** - Backups, migrations, replication
9. **Security Scanning** - Vulnerability scanning, SAST, DAST
10. **Performance Testing** - Load testing, stress testing

## 🎓 Learning Path

Use this application to learn:

1. **Week 1-2**: Containerize with Docker
2. **Week 3-4**: Setup CI/CD pipeline
3. **Week 5-6**: Deploy to cloud (AWS/GCP/Azure)
4. **Week 7-8**: Add monitoring (Prometheus + Grafana)
5. **Week 9-10**: Setup Kubernetes deployment
6. **Week 11-12**: Implement GitOps workflow
7. **Week 13-14**: Add security scanning
8. **Week 15-16**: Performance testing and optimization

## 🤝 Contributing

This is an open educational project. Feel free to:
- Fork and modify for your DevOps projects
- Create tutorials and blog posts using this app
- Add new features and improvements
- Share your deployment strategies

## 📝 License

This project is provided as-is for educational and demonstration purposes.

## 🙏 Credits

Built for aspiring DevOps engineers who want to work with real, production-grade applications instead of simple demos.

## 📬 Support

- Check [SETUP.md](SETUP.md) for installation issues
- Review [docs/API.md](docs/API.md) for API questions
- See [COMMANDS.md](COMMANDS.md) for command help

---

**Ready to start your DevOps journey?** Follow the [Quick Start](#-quick-start) guide above!
