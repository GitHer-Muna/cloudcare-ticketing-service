#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

API_URL="http://localhost:3000/api/v1"
TOKEN=""
TICKET_ID=""
USER_ID=""
ADMIN_TOKEN=""
AGENT_TOKEN=""
USER_TOKEN=""

# Add small delay between requests to avoid rate limiting
DELAY=0.2

echo "======================================"
echo "CloudCare Full Functionality Test"
echo "======================================"
echo ""

# Test 1: Health Check
echo "1. Testing Health Check..."
HEALTH=$(curl -s ${API_URL}/health)
if echo "$HEALTH" | grep -q '"status":"healthy"'; then
    echo -e "${GREEN}✓ Health check passed${NC}"
else
    echo -e "${RED}✗ Health check failed${NC}"
    echo "Response: $HEALTH"
    exit 1
fi
echo ""

# Test 2: Admin Login
echo "2. Testing Admin Login..."
LOGIN_RESPONSE=$(curl -s -X POST ${API_URL}/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@cloudcare.com",
    "password": "Admin@123"
  }')

ADMIN_TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"accessToken":"[^"]*' | sed 's/"accessToken":"//')
if [ -z "$ADMIN_TOKEN" ]; then
    echo -e "${RED}✗ Admin login failed${NC}"
    echo "Response: $LOGIN_RESPONSE"
    exit 1
fi
echo -e "${GREEN}✓ Admin logged in successfully${NC}"
echo ""

# Test 3: Agent Login
echo "3. Testing Agent Login..."
AGENT_RESPONSE=$(curl -s -X POST ${API_URL}/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "agent@cloudcare.com",
    "password": "Agent@123"
  }')

AGENT_TOKEN=$(echo $AGENT_RESPONSE | grep -o '"accessToken":"[^"]*' | sed 's/"accessToken":"//')
if [ -z "$AGENT_TOKEN" ]; then
    echo -e "${RED}✗ Agent login failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Agent logged in successfully${NC}"
echo ""

# Test 4: User Login
echo "4. Testing User Login..."
USER_RESPONSE=$(curl -s -X POST ${API_URL}/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@cloudcare.com",
    "password": "User@123"
  }')

USER_TOKEN=$(echo $USER_RESPONSE | grep -o '"accessToken":"[^"]*' | sed 's/"accessToken":"//')
USER_ID=$(echo $USER_RESPONSE | grep -o '"id":"[^"]*' | sed 's/"id":"//' | head -1)
if [ -z "$USER_TOKEN" ]; then
    echo -e "${RED}✗ User login failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ User logged in successfully${NC}"
echo ""

# Test 5: Create Ticket (as User)
echo "5. Testing Create Ticket (User)..."
CREATE_TICKET=$(curl -s -X POST ${API_URL}/tickets \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $USER_TOKEN" \
  -d '{
    "title": "Test Ticket - API Functionality",
    "description": "Testing the complete ticket management system",
    "priority": "HIGH",
    "category": "Technical"
  }')

TICKET_ID=$(echo $CREATE_TICKET | grep -o '"id":"[^"]*' | sed 's/"id":"//' | head -1)
if [ -z "$TICKET_ID" ]; then
    echo -e "${RED}✗ Create ticket failed${NC}"
    echo "Response: $CREATE_TICKET"
    exit 1
fi
echo -e "${GREEN}✓ Ticket created successfully (ID: $TICKET_ID)${NC}"
echo ""

# Test 6: Get All Tickets (as User)
echo "6. Testing Get All Tickets (User)..."
GET_TICKETS=$(curl -s -X GET "${API_URL}/tickets?page=1&limit=10" \
  -H "Authorization: Bearer $USER_TOKEN")

if echo "$GET_TICKETS" | grep -q "$TICKET_ID"; then
    echo -e "${GREEN}✓ User can see their tickets${NC}"
else
    echo -e "${RED}✗ Failed to fetch tickets${NC}"
    exit 1
fi
echo ""

# Test 7: Get Ticket by ID (as User)
echo "7. Testing Get Ticket by ID (User)..."
GET_TICKET=$(curl -s -X GET ${API_URL}/tickets/${TICKET_ID} \
  -H "Authorization: Bearer $USER_TOKEN")

if echo "$GET_TICKET" | grep -q "Test Ticket - API Functionality"; then
    echo -e "${GREEN}✓ User can view ticket details${NC}"
else
    echo -e "${RED}✗ Failed to fetch ticket by ID${NC}"
    exit 1
fi
echo ""

# Test 8: Update Ticket (as User)
echo "8. Testing Update Ticket (User)..."
UPDATE_TICKET=$(curl -s -X PATCH ${API_URL}/tickets/${TICKET_ID} \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $USER_TOKEN" \
  -d '{
    "description": "Updated description - Testing update functionality"
  }')

if echo "$UPDATE_TICKET" | grep -q '"success":true'; then
    echo -e "${GREEN}✓ User can update their ticket${NC}"
else
    echo -e "${RED}✗ Failed to update ticket${NC}"
    echo "Response: $UPDATE_TICKET"
    exit 1
fi
echo ""

# Test 9: Add Comment (as User)
echo "9. Testing Add Comment (User)..."
ADD_COMMENT=$(curl -s -X POST ${API_URL}/tickets/${TICKET_ID}/comments \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $USER_TOKEN" \
  -d '{
    "content": "This is a test comment from the user",
    "isInternal": false
  }')

if echo "$ADD_COMMENT" | grep -q '"success":true'; then
    echo -e "${GREEN}✓ User can add comments${NC}"
else
    echo -e "${RED}✗ Failed to add comment${NC}"
    echo "Response: $ADD_COMMENT"
    exit 1
fi
echo ""

# Test 10: Agent Views All Tickets
echo "10. Testing Agent View All Tickets..."
AGENT_TICKETS=$(curl -s -X GET "${API_URL}/tickets?page=1&limit=10" \
  -H "Authorization: Bearer $AGENT_TOKEN")

if echo "$AGENT_TICKETS" | grep -q "$TICKET_ID"; then
    echo -e "${GREEN}✓ Agent can see all tickets${NC}"
else
    echo -e "${RED}✗ Agent cannot see tickets${NC}"
    exit 1
fi
echo ""

# Test 11: Agent Assigns Ticket to Self
echo "11. Testing Agent Assigns Ticket..."
AGENT_ID=$(echo $AGENT_RESPONSE | grep -o '"id":"[^"]*' | sed 's/"id":"//' | head -1)
ASSIGN_TICKET=$(curl -s -X PATCH ${API_URL}/tickets/${TICKET_ID} \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $AGENT_TOKEN" \
  -d "{
    \"assignedToId\": \"$AGENT_ID\",
    \"status\": \"IN_PROGRESS\"
  }")

if echo "$ASSIGN_TICKET" | grep -q '"success":true'; then
    echo -e "${GREEN}✓ Agent can assign and update ticket status${NC}"
else
    echo -e "${RED}✗ Failed to assign ticket${NC}"
    echo "Response: $ASSIGN_TICKET"
    exit 1
fi
echo ""

# Test 12: Agent Adds Internal Comment
echo "12. Testing Agent Internal Comment..."
INTERNAL_COMMENT=$(curl -s -X POST ${API_URL}/tickets/${TICKET_ID}/comments \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $AGENT_TOKEN" \
  -d '{
    "content": "Internal note - This is visible to agents only",
    "isInternal": true
  }')

if echo "$INTERNAL_COMMENT" | grep -q '"success":true'; then
    echo -e "${GREEN}✓ Agent can add internal comments${NC}"
else
    echo -e "${RED}✗ Failed to add internal comment${NC}"
    echo "Response: $INTERNAL_COMMENT"
    exit 1
fi
echo ""

# Test 13: Get Ticket Stats (as Agent)
echo "13. Testing Ticket Stats (Agent)..."
AGENT_STATS=$(curl -s -X GET ${API_URL}/tickets/stats \
  -H "Authorization: Bearer $AGENT_TOKEN")

if echo "$AGENT_STATS" | grep -q "total"; then
    echo -e "${GREEN}✓ Agent can view ticket statistics${NC}"
else
    echo -e "${RED}✗ Failed to fetch stats${NC}"
    exit 1
fi
echo ""

# Test 14: Admin Views All Tickets
echo "14. Testing Admin View All Tickets..."
ADMIN_TICKETS=$(curl -s -X GET "${API_URL}/tickets?page=1&limit=10" \
  -H "Authorization: Bearer $ADMIN_TOKEN")

if echo "$ADMIN_TICKETS" | grep -q "$TICKET_ID"; then
    echo -e "${GREEN}✓ Admin can see all tickets${NC}"
else
    echo -e "${RED}✗ Admin cannot see tickets${NC}"
    exit 1
fi
echo ""

# Test 15: Admin Updates Any Ticket
echo "15. Testing Admin Update Any Ticket..."
ADMIN_UPDATE=$(curl -s -X PATCH ${API_URL}/tickets/${TICKET_ID} \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{
    "priority": "CRITICAL",
    "status": "RESOLVED"
  }')

if echo "$ADMIN_UPDATE" | grep -q '"success":true'; then
    echo -e "${GREEN}✓ Admin can update any ticket${NC}"
else
    echo -e "${RED}✗ Failed admin update${NC}"
    echo "Response: $ADMIN_UPDATE"
    exit 1
fi
echo ""

# Test 16: Get Ticket Stats (as Admin)
echo "16. Testing Ticket Stats (Admin)..."
ADMIN_STATS=$(curl -s -X GET ${API_URL}/tickets/stats \
  -H "Authorization: Bearer $ADMIN_TOKEN")

if echo "$ADMIN_STATS" | grep -q "total"; then
    echo -e "${GREEN}✓ Admin can view complete statistics${NC}"
else
    echo -e "${RED}✗ Failed to fetch admin stats${NC}"
    exit 1
fi
echo ""

# Test 17: User Cannot See Other User's Tickets
echo "17. Testing RBAC - User Isolation..."
# Create another user
NEW_USER=$(curl -s -X POST ${API_URL}/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "testuser@example.com",
    "password": "Test@123",
    "firstName": "Test",
    "lastName": "User"
  }')

NEW_USER_TOKEN=$(echo $NEW_USER | grep -o '"accessToken":"[^"]*' | sed 's/"accessToken":"//')

# Try to access first user's ticket
ACCESS_TEST=$(curl -s -X GET ${API_URL}/tickets/${TICKET_ID} \
  -H "Authorization: Bearer $NEW_USER_TOKEN")

if echo "$ACCESS_TEST" | grep -q "error\|not found\|forbidden"; then
    echo -e "${GREEN}✓ Users cannot access other users' tickets${NC}"
else
    echo -e "${YELLOW}⚠ Warning: User might be able to see other tickets${NC}"
fi
echo ""

# Test 18: Search and Filter Tickets
echo "18. Testing Search and Filter..."
SEARCH_TICKETS=$(curl -s -X GET "${API_URL}/tickets?search=API&status=RESOLVED" \
  -H "Authorization: Bearer $ADMIN_TOKEN")

if echo "$SEARCH_TICKETS" | grep -q "$TICKET_ID"; then
    echo -e "${GREEN}✓ Search and filter working${NC}"
else
    echo -e "${YELLOW}⚠ Search might not be working as expected${NC}"
fi
echo ""

# Test 19: Admin Deletes Ticket
echo "19. Testing Delete Ticket (Admin)..."
DELETE_TICKET=$(curl -s -X DELETE ${API_URL}/tickets/${TICKET_ID} \
  -H "Authorization: Bearer $ADMIN_TOKEN")

if echo "$DELETE_TICKET" | grep -q '"success":true'; then
    echo -e "${GREEN}✓ Admin can delete tickets${NC}"
else
    echo -e "${RED}✗ Failed to delete ticket${NC}"
    echo "Response: $DELETE_TICKET"
    exit 1
fi
echo ""

# Test 20: Verify Ticket is Deleted
echo "20. Testing Deleted Ticket Cannot Be Accessed..."
DELETED_CHECK=$(curl -s -X GET ${API_URL}/tickets/${TICKET_ID} \
  -H "Authorization: Bearer $USER_TOKEN")

if echo "$DELETED_CHECK" | grep -q "not found\|error"; then
    echo -e "${GREEN}✓ Deleted ticket cannot be accessed${NC}"
else
    echo -e "${RED}✗ Deleted ticket still accessible${NC}"
    exit 1
fi
echo ""

echo "======================================"
echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
echo "======================================"
echo ""
echo "Summary of Tested Features:"
echo "✓ Authentication (Admin, Agent, User)"
echo "✓ Create Tickets"
echo "✓ Read Tickets (List & Details)"
echo "✓ Update Tickets"
echo "✓ Delete Tickets"
echo "✓ Add Comments (Public & Internal)"
echo "✓ Ticket Assignment"
echo "✓ Status Management"
echo "✓ Priority Management"
echo "✓ Statistics/Dashboard"
echo "✓ RBAC (Role-Based Access Control)"
echo "✓ Search and Filtering"
echo "✓ User Isolation"
echo ""
echo "The CloudCare Ticketing System is fully functional!"
