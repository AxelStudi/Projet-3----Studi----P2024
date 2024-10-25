// src/__tests__/Cart.test.js
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import Cart from '../components/Cart/Cart';
import { CartContext } from '../context/CartContext';
import { AuthContext } from '../context/AuthContext';
import { BrowserRouter } from 'react-router-dom';
import api from '../services/api';

// Mock de l'API
jest.mock('../services/api');

const renderCart = (cartItems, user) => {
  render(
    <AuthContext.Provider value={{ user }}>
      <CartContext.Provider value={{
        cartItems,
        removeFromCart: jest.fn(),
        clearCart: jest.fn(),
      }}>
        <BrowserRouter>
          <Cart />
        </BrowserRouter>
      </CartContext.Provider>
    </AuthContext.Provider>
  );
};

test('affiche un panier vide', () => {
  renderCart([], { id: 1, name: 'John Doe' });
  expect(screen.getByText(/Votre panier est vide/i)).toBeInTheDocument();
});

test('affiche les articles du panier', () => {
  const items = [
    { id: 1, name: 'Offre Solo', description: 'Un billet pour une personne', price: 50 },
    { id: 2, name: 'Offre Duo', description: 'Deux billets pour deux personnes', price: 90 },
  ];
  renderCart(items, { id: 1, name: 'John Doe' });

  expect(screen.getByText('Offre Solo')).toBeInTheDocument();
  expect(screen.getByText('Un billet pour une personne')).toBeInTheDocument();
  expect(screen.getByText('Prix : 50€')).toBeInTheDocument();

  expect(screen.getByText('Offre Duo')).toBeInTheDocument();
  expect(screen.getByText('Deux billets pour deux personnes')).toBeInTheDocument();
  expect(screen.getByText('Prix : 90€')).toBeInTheDocument();
});

test('procède au paiement avec succès', async () => {
  const items = [
    { id: 1, name: 'Offre Solo', description: 'Un billet pour une personne', price: 50 },
  ];
  const mockClearCart = jest.fn();
  const mockTicketKey = 'abc123';

  api.post.mockResolvedValueOnce({ data: { ticket_key: mockTicketKey } });

  render(
    <AuthContext.Provider value={{ user: { id: 1, name: 'John Doe' } }}>
      <CartContext.Provider value={{
        cartItems: items,
        removeFromCart: jest.fn(),
        clearCart: mockClearCart,
      }}>
        <BrowserRouter>
          <Cart />
        </BrowserRouter>
      </CartContext.Provider>
    </AuthContext.Provider>
  );

  const checkoutButton = screen.getByText(/Procéder au Paiement/i);
  fireEvent.click(checkoutButton);

  expect(api.post).toHaveBeenCalledWith('/checkout/', { user_id: 1, items: [1] });

  // Attendez que le billet soit affiché
  const billetHeading = await screen.findByText(/Achat Réussi/i);
  expect(billetHeading).toBeInTheDocument();
  expect(screen.getByText(/Votre e-Billet/i)).toBeInTheDocument();
});
