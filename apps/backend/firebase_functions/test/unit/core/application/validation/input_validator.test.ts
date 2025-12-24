import { InputValidator, ValidationError } from '../../../../../src/core/application/validation/input_validator';

describe('InputValidator', () => {
  describe('validateString', () => {
    it('should validate a valid string', () => {
      const result = InputValidator.validateString('test', 'field');
      expect(result.isValid).toBe(true);
      expect(result.errors).toHaveLength(0);
    });

    it('should fail when required string is missing', () => {
      const result = InputValidator.validateString(undefined, 'field', {
        required: true,
      });
      expect(result.isValid).toBe(false);
      expect(result.errors.length).toBeGreaterThan(0);
    });

    it('should fail when value is not a string', () => {
      const result = InputValidator.validateString(123, 'field');
      expect(result.isValid).toBe(false);
      expect(result.errors).toContain('field must be a string');
    });

    it('should validate minLength', () => {
      const result = InputValidator.validateString('ab', 'field', {
        minLength: 3,
      });
      expect(result.isValid).toBe(false);
      expect(result.errors).toContain('field must be at least 3 characters');
    });

    it('should validate maxLength', () => {
      const result = InputValidator.validateString('abcdef', 'field', {
        maxLength: 5,
      });
      expect(result.isValid).toBe(false);
      expect(result.errors).toContain('field must be at most 5 characters');
    });

    it('should allow undefined when not required', () => {
      const result = InputValidator.validateString(undefined, 'field');
      expect(result.isValid).toBe(true);
    });
  });

  describe('validateEmail', () => {
    it('should validate a valid email', () => {
      const result = InputValidator.validateEmail('test@example.com', 'email');
      expect(result.isValid).toBe(true);
      expect(result.errors).toHaveLength(0);
    });

    it('should fail when email is missing', () => {
      const result = InputValidator.validateEmail(undefined, 'email');
      expect(result.isValid).toBe(false);
    });

    it('should fail when email format is invalid', () => {
      const result = InputValidator.validateEmail('invalid-email', 'email');
      expect(result.isValid).toBe(false);
      expect(result.errors).toContain('email must be a valid email address');
    });
  });
});

