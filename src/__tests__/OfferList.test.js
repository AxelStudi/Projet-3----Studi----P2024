// src/__tests__/OfferList.test.js
import { render, screen, fireEvent } from '@testing-library/react';
import OfferList from '../components/Offers/OfferList';

test('renders list of offers', () => {
  const mockOffers = [
    { id: 1, title: 'Solo', description: 'Accès individuel', price: 50 },
    { id: 2, title: 'Duo', description: 'Accès pour deux personnes', price: 90 },
  ];
  const mockAddToCart = jest.fn();

  render(<OfferList offers={mockOffers} addToCart={mockAddToCart} />);

  mockOffers.forEach((offer) => {
    expect(screen.getByText(offer.title)).toBeInTheDocument();
    expect(screen.getByText(offer.description)).toBeInTheDocument();
  });

  fireEvent.click(screen.getByText(/Ajouter au panier/i));
  expect(mockAddToCart).toHaveBeenCalledWith(mockOffers[0]);
});
