import express from 'express';
import { helloRouter } from './presentation/routes/hello.routes';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use('/api', helloRouter);

const server = app.listen(PORT, () => {
  if (process.env.NODE_ENV !== 'test') {
    console.log(`Server is running on http://localhost:${PORT}`);
  }
});

export default app;
export { server };

