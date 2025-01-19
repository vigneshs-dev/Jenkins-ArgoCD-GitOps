const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Serve static files
app.use(express.static('public'));

// Backend route
app.get('/hello', (req, res) => {
  res.send('Hi. I am Vicky. Have a nice day!');
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
