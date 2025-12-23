import request from 'supertest';
import app, { server } from '../../src/index';

describe('Hello E2E Tests', () => {
  afterAll((done) => {
    server.close(done);
  });

  describe('GET /api/hello', () => {
    it('should return hello world message', async () => {
      const response = await request(app)
        .get('/api/hello')
        .expect(200);

      expect(response.body).toEqual({ message: 'Hello, World!' });
    });

    it('should return JSON content type', async () => {
      const response = await request(app)
        .get('/api/hello')
        .expect(200)
        .expect('Content-Type', /json/);

      expect(response.body).toHaveProperty('message');
    });
  });
});

