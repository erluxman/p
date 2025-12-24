import * as functions from 'firebase-functions';
import { CallableContext } from 'firebase-functions/v1/https';

interface AuthenticatedRequest {
  message?: string;
}

export const authenticatedExample = async (
  data: AuthenticatedRequest,
  context: CallableContext
) => {
    const logger = functions.logger;

    try {
      if (!context.auth) {
        throw new functions.https.HttpsError(
          'unauthenticated',
          'The function must be called while authenticated.'
        );
      }

      logger.info('Authenticated function invoked', {
        uid: context.auth.uid,
      });

      const message = data.message || 'Hello from authenticated function!';

      return {
        success: true,
        message,
        user: {
          uid: context.auth.uid,
        },
        timestamp: new Date().toISOString(),
      };
    } catch (error) {
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      logger.error('Error in authenticatedExample function', {
        error: error instanceof Error ? error.message : 'Unknown error',
      });

      throw new functions.https.HttpsError(
        'internal',
        'An error occurred processing the request'
      );
    }
  };

