 // agtech-saas/api/src/index.ts

import dotenv from 'dotenv';
import { createServer } from 'http';
import { Server } from 'socket.io';
import app from './app';
import { connectDatabases } from './config/database';
import { initializeSocketIO } from './config/socket';
import { logger } from './utils/logger';

// Load environment variables
dotenv.config();

const PORT = process.env.PORT || 3000;

// Create HTTP server
const httpServer = createServer(app);

// Initialize Socket.IO
const io = new Server(httpServer, {
  cors: {
    origin: process.env.WEB_URL || 'http://localhost:5173',
    credentials: true
  }
});

// Initialize Socket.IO handlers
initializeSocketIO(io);

// Start server
const startServer = async () => {
  try {
    // Connect to databases
    await connectDatabases();
    
    // Start HTTP server
    httpServer.listen(PORT, () => {
      logger.info(`🚀 AgTech API Server başlatıldı - Port: ${PORT}`);
      logger.info(`📡 WebSocket server hazır`);
      logger.info(`🌍 Environment: ${process.env.NODE_ENV}`);
    });

    // Graceful shutdown
    process.on('SIGTERM', () => {
      logger.info('SIGTERM sinyali alındı, server kapatılıyor...');
      httpServer.close(() => {
        logger.info('Server kapatıldı');
        process.exit(0);
      });
    });

  } catch (error) {
    logger.error('Server başlatma hatası:', error);
    process.exit(1);
  }
};

// Handle unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  logger.error('Unhandled Rejection at:', promise, 'reason:', reason);
  // Application specific logging, throwing an error, or other logic here
});

startServer();