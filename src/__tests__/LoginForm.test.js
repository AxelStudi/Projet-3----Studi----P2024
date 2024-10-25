// Login.test.js
import { render, screen, fireEvent } from '@testing-library/react';
import Login from '../components/Auth/Login';

test('calls login function when form is submitted', () => {
  const mockLogin = jest.fn();
  render(<Login login={mockLogin} />);

  fireEvent.change(screen.getByLabelText(/Email/i), { target: { value: 'user@example.com' } });
  fireEvent.change(screen.getByLabelText(/Mot de passe/i), { target: { value: 'password123' } });
  fireEvent.click(screen.getByText(/Se connecter/i));

  expect(mockLogin).toHaveBeenCalledWith('user@example.com', 'password123');
});
