import { Router, Request, Response } from 'express';
import { helloController } from '../controllers/hello.controller';

export const helloRouter = Router();

helloRouter.get('/hello', helloController.getHello);

