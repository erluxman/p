import { Request, Response } from 'express';
import * as functions from 'firebase-functions';

export const helloWorld = async (req: Request, res: Response): Promise<void> => {
  try {
    const logger = functions.logger;
    const requestId = req.headers['x-request-id'] || 'unknown';

    logger.info('HelloWorld function invoked', {
      requestId,
      method: req.method,
      path: req.path,
    });

    res.status(200).json({
      message: 'Hello from Firebase Functions!',
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    const logger = functions.logger;
    logger.error('Error in helloWorld function', {
      error: error instanceof Error ? error.message : 'Unknown error',
    });

    res.status(500).json({
      error: 'Internal server error',
    });
  }
};

