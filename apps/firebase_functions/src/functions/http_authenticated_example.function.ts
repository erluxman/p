import { Request, Response } from 'express';
import * as functions from 'firebase-functions';
import { verifyAuthToken } from '../infrastructure/auth/auth_verifier';

export const httpAuthenticatedExample = async (
  req: Request,
  res: Response
): Promise<void> => {
  const logger = functions.logger;

  try {
    const authHeader = req.headers.authorization;
    const authContext = await verifyAuthToken(authHeader);

    logger.info('HTTP authenticated function invoked', {
      requestId: req.headers['x-request-id'] || 'unknown',
      uid: authContext.uid,
      email: authContext.email,
    });

    res.status(200).json({
      success: true,
      message: 'Hello from authenticated HTTP function!',
      user: {
        uid: authContext.uid,
        email: authContext.email,
      },
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    if (error instanceof functions.https.HttpsError) {
      const statusCode = error.code === 'unauthenticated' ? 401 : 500;
      res.status(statusCode).json({
        error: error.message,
      });
      return;
    }

    logger.error('Error in httpAuthenticatedExample function', {
      error: error instanceof Error ? error.message : 'Unknown error',
    });

    res.status(500).json({
      error: 'Internal server error',
    });
  }
};

