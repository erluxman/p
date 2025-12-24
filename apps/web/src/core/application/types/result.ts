export type Result<T, E = string> =
  | { success: true; data: T }
  | { success: false; error: E };

export const createSuccess = <T>(data: T): Result<T, never> => ({
  success: true,
  data,
});

export const createFailure = <E>(error: E): Result<never, E> => ({
  success: false,
  error,
});
