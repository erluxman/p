export class ValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

export interface ValidationResult {
  isValid: boolean;
  errors: string[];
}

export class InputValidator {
  static validateString(
    value: unknown,
    fieldName: string,
    options?: {
      required?: boolean;
      minLength?: number;
      maxLength?: number;
    }
  ): ValidationResult {
    const errors: string[] = [];

    if (options?.required && (!value || typeof value !== 'string')) {
      errors.push(`${fieldName} is required and must be a string`);
      return { isValid: false, errors };
    }

    if (value === undefined || value === null) {
      return { isValid: true, errors: [] };
    }

    if (typeof value !== 'string') {
      errors.push(`${fieldName} must be a string`);
      return { isValid: false, errors };
    }

    const stringValue = value as string;

    if (options?.minLength && stringValue.length < options.minLength) {
      errors.push(
        `${fieldName} must be at least ${options.minLength} characters`
      );
    }

    if (options?.maxLength && stringValue.length > options.maxLength) {
      errors.push(
        `${fieldName} must be at most ${options.maxLength} characters`
      );
    }

    return {
      isValid: errors.length === 0,
      errors,
    };
  }

  static validateEmail(value: unknown, fieldName: string): ValidationResult {
    const stringResult = this.validateString(value, fieldName, { required: true });

    if (!stringResult.isValid) {
      return stringResult;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const stringValue = value as string;

    if (!emailRegex.test(stringValue)) {
      return {
        isValid: false,
        errors: [`${fieldName} must be a valid email address`],
      };
    }

    return { isValid: true, errors: [] };
  }
}

