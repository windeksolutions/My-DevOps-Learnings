const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

app.get('/api/dashboard', (req, res) => {
  res.json({
    users: [
      { id: 1, name: 'Alice', role: 'admin' },
      { id: 2, name: 'Bob', role: 'user' },
      { id: 3, name: 'Charlie', role: 'user' }
    ]
  });
});

app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    service: 'dashboard-service'
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Dashboard service listening on port ${PORT}`);
});