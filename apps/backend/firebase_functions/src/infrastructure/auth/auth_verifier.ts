import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

if (!admin.apps.length) {
  admin.initializeApp();
}

export interface AuthContext {
  uid: string;
  email?: string;
}

export async function verifyAuthToken(
  authHeader: string | undefined
): Promise<AuthContext> {
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'Missing or invalid authorization header'
    );
  }

  const token = authHeader.split('Bearer ')[1];

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    
    return {
      uid: decodedToken.uid,
      email: decodedToken.email,
    };
  } catch (error) {
    const logger = functions.logger;
    logger.warn('Token verification failed', {
      error: error instanceof Error ? error.message : 'Unknown error',
    });

    throw new functions.https.HttpsError(
      'unauthenticated',
      'Invalid authentication token'
    );
  }
}

