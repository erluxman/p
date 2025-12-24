import { Request, Response } from 'express';
import { helloController } from '../../src/presentation/controllers/hello.controller';

describe('Hello Controller', () => {
  let mockRequest: Partial<Request>;
  let mockResponse: Partial<Response>;
  let responseJson: jest.Mock;
  let responseStatus: jest.Mock;

  beforeEach(() => {
    responseJson = jest.fn();
    responseStatus = jest.fn().mockReturnValue({ json: responseJson });
    
    mockRequest = {};
    mockResponse = {
      status: responseStatus,
      json: responseJson,
    };
  });

  describe('getHello', () => {
    it('should return hello world message with status 200', () => {
      helloController.getHello(
        mockRequest as Request,
        mockResponse as Response
      );

      expect(responseStatus).toHaveBeenCalledWith(200);
      expect(responseJson).toHaveBeenCalledWith({ message: 'Hello, World!' });
    });
  });
});

