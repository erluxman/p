import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { Hello } from '../../src/presentation/components/Hello';

describe('Hello Component', () => {
  it('should render hello world message', () => {
    render(<Hello />);
    
    const heading = screen.getByRole('heading', { name: /hello, world!/i });
    expect(heading).toBeInTheDocument();
  });

  it('should have correct test id', () => {
    render(<Hello />);
    
    const component = screen.getByTestId('hello-component');
    expect(component).toBeInTheDocument();
  });
});

