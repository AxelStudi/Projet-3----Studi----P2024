// src/__tests__/Register.test.js
import { render, screen, fireEvent } from '@testing-library/react';
import Register from '../components/Auth/Register';

test('submits registration form', () => {
  const mockRegisterUser = jest.fn();
  render(<Register registerUser={mockRegisterUser} />);

  fireEvent.change(screen.getByLabelText(/Nom d'utilisateur/i), {
    target: { value: 'newuser' },
  });
  fireEvent.change(screen.getByLabelText(/Email/i), { target: { value: 'user@example.com' } });
  fireEvent.change(screen.getByLabelText(/Mot de passe/i), { target: { value: 'password123' } });

  fireEvent.click(screen.getByText(/S'inscrire/i));
  expect(mockRegisterUser).toHaveBeenCalledWith({
    username: 'newuser',
    email: 'user@example.com',
    password: 'password123',
  });
});
