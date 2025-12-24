import { Request, Response } from 'express';
import { helloWorld } from '../../../src/functions/hello.function';

describe('helloWorld', () => {
  let mockRequest: Partial<Request>;
  let mockResponse: Partial<Response>;
  let responseJson: jest.Mock;
  let responseStatus: jest.Mock;

  beforeEach(() => {
    responseJson = jest.fn();
    responseStatus = jest.fn().mockReturnValue({ json: responseJson });
    
    mockRequest = {
      method: 'GET',
      path: '/',
      headers: {
        'x-request-id': 'test-request-id',
      },
    };

    mockResponse = {
      status: responseStatus,
      json: responseJson,
    };
  });

  it('should return 200 with hello message', async () => {
    await helloWorld(mockRequest as Request, mockResponse as Response);

    expect(responseStatus).toHaveBeenCalledWith(200);
    expect(responseJson).toHaveBeenCalledWith({
      message: 'Hello from Firebase Functions!',
      timestamp: expect.any(String),
    });
  });

  it('should handle errors gracefully', async () => {
    const errorRequest = {
      ...mockRequest,
      headers: {},
    } as Request;

    await helloWorld(errorRequest, mockResponse as Response);

    expect(responseStatus).toHaveBeenCalled();
  });
});

