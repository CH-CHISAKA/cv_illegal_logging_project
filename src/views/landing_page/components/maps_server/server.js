

// const express = require('express');
// const WebSocket = require('ws');
// const http = require('http');

// // Set up Express app
// const app = express();
// const server = http.createServer(app);

// // WebSocket server setup
// const wss = new WebSocket.Server({ server });

// // Broadcast data to all connected clients
// wss.on('connection', (ws) => {
//   console.log('Client connected');
  
//   // Simulating sending GPS data (coordinates) every 5 seconds
//   setInterval(() => {
//     const gpsData = {
//       lat: 51.505 + Math.random() * 0.01,  // Random latitude near a fixed point
//       lng: -0.09 + Math.random() * 0.01,  // Random longitude near a fixed point
//       timestamp: Date.now()
//     };
//     ws.send(JSON.stringify(gpsData));  // Send the data to the client
//   }, 5000);
// });

// // Serve static files (optional)
// app.use(express.static('public'));

// // Start the server
// const port = 8080;
// server.listen(port, () => {
//   console.log(`Server is running on ws://localhost:${port}`);
// });

// app.get('/logs', (req, res) => {
//   const logs = [
//     { lat: 51.505, lng: -0.09, description: 'Logging activity detected' },
//     // Add more log data as needed
//   ];
//   res.json(logs);
// });

// // On the server (Node.js)
// const loggingData = { lat: 51.505, lng: -0.09, detected: true };
// if (loggingData.detected) {
//   wss.clients.forEach(client => {
//     if (client.readyState === WebSocket.OPEN) {
//       client.send(JSON.stringify(loggingData));
//     }
//   });
// }

// import 'leaflet.heat';

// const heatData = [
//   [51.505, -0.09, 0.5],  // lat, lng, intensity
//   [51.515, -0.1, 0.8],
//   // Add more data points
// ];

// L.heatLayer(heatData, { radius: 25 }).addTo(map.value);

const express = require('express');
const WebSocket = require('ws');
const http = require('http');

// Set up Express app
const app = express();
const server = http.createServer(app);

// WebSocket server setup
const wss = new WebSocket.Server({ server });

// Broadcast data to all connected clients
wss.on('connection', (ws) => {
  console.log('Client connected');
  
  // Simulating sending GPS data (coordinates) every 5 seconds
  setInterval(() => {
    const gpsData = {
      lat: 51.505 + Math.random() * 0.01,  // Random latitude near a fixed point
      lng: -0.09 + Math.random() * 0.01,  // Random longitude near a fixed point
      timestamp: Date.now()
    };
    ws.send(JSON.stringify(gpsData));  // Send the data to the client
  }, 5000);
});

// Serve static files (optional)
app.use(express.static('public'));

// Start the server
const port = 8080;
server.listen(port, () => {
  console.log(`Server is running on ws://localhost:${port}`);
});
