import * as functions from 'firebase-functions';
import { helloWorld } from './functions/hello.function';
import { authenticatedExample } from './functions/authenticated_example.function';
import { httpAuthenticatedExample } from './functions/http_authenticated_example.function';
//add comment
const region = 'us-central1';

export const helloWorldFunction = functions
  .region(region)
  .https.onRequest(helloWorld);

export const authenticatedExampleFunction = functions
  .region(region)
  .https.onCall(authenticatedExample);

export const httpAuthenticatedExampleFunction = functions
  .region(region)
  .https.onRequest(httpAuthenticatedExample);

