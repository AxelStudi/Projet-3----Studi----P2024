// src/__tests__/App.test.js
import { render, screen } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';
import App from '../App';

test('renders welcome message and main navigation', () => {
  render(
    <BrowserRouter>
      <App />
    </BrowserRouter>
  );

  expect(screen.getByText(/Bienvenue aux JO 2024/i)).toBeInTheDocument();
  expect(screen.getByText(/Accueil/i)).toBeInTheDocument();
  expect(screen.getByText(/Offres/i)).toBeInTheDocument();
});
