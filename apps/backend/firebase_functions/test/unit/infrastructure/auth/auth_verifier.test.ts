import * as admin from 'firebase-admin';
import { verifyAuthToken } from '../../../../src/infrastructure/auth/auth_verifier';

jest.mock('firebase-admin', () => ({
  apps: [],
  auth: jest.fn(),
  initializeApp: jest.fn(),
}));

describe('verifyAuthToken', () => {
  const mockVerifyIdToken = jest.fn();

  beforeEach(() => {
    jest.clearAllMocks();
    (admin.auth as jest.Mock).mockReturnValue({
      verifyIdToken: mockVerifyIdToken,
    });
  });

  it('should throw error when auth header is missing', async () => {
    await expect(verifyAuthToken(undefined)).rejects.toThrow();
  });

  it('should throw error when auth header does not start with Bearer', async () => {
    await expect(verifyAuthToken('Invalid token')).rejects.toThrow();
  });

  it('should return auth context when token is valid', async () => {
    const mockDecodedToken = {
      uid: 'test-uid',
      email: 'test@example.com',
    };

    mockVerifyIdToken.mockResolvedValue(mockDecodedToken);

    const result = await verifyAuthToken('Bearer valid-token');

    expect(result).toEqual({
      uid: 'test-uid',
      email: 'test@example.com',
    });
    expect(mockVerifyIdToken).toHaveBeenCalledWith('valid-token');
  });

  it('should throw error when token verification fails', async () => {
    mockVerifyIdToken.mockRejectedValue(new Error('Invalid token'));

    await expect(verifyAuthToken('Bearer invalid-token')).rejects.toThrow();
  });
});

