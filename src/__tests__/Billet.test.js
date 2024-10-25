// src/__tests__/Billet.test.js
import { render, screen } from '@testing-library/react';
import Billet from '../components/Billet/Billet';

test('renders ticket information', () => {
  const mockTicketKey = 'SampleTicketKey1234';

  render(<Billet ticketKey={mockTicketKey} />);

  expect(screen.getByText('Votre e-Billet')).toBeInTheDocument();
  expect(screen.getByText('Scannez ce QR Code le jour des Jeux Olympiques pour valider votre billet.')).toBeInTheDocument();
  expect(screen.getByRole('img', { hidden: true })).toBeInTheDocument();
});
