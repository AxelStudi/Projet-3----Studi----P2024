// src/__tests__/Navbar.test.js
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import Navbar from '../components/Navbar/Navbar';
import { AuthContext } from '../context/AuthContext';
import { BrowserRouter } from 'react-router-dom';

describe('Navbar', () => {
  test('affiche les liens pour les utilisateurs non authentifiés', () => {
    render(
      <AuthContext.Provider value={{ isAuthenticated: false }}>
        <BrowserRouter>
          <Navbar />
        </BrowserRouter>
      </AuthContext.Provider>
    );

    expect(screen.getByText(/Accueil/i)).toBeInTheDocument();
    expect(screen.getByText(/Offres/i)).toBeInTheDocument();
    expect(screen.getByText(/Connexion/i)).toBeInTheDocument();
    expect(screen.getByText(/Inscription/i)).toBeInTheDocument();
    expect(screen.queryByText(/Panier/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Admin/i)).not.toBeInTheDocument();
  });

  test('affiche les liens pour les utilisateurs authentifiés', () => {
    render(
      <AuthContext.Provider value={{ isAuthenticated: true, user: { role: 'user' }, logout: jest.fn() }}>
        <BrowserRouter>
          <Navbar />
        </BrowserRouter>
      </AuthContext.Provider>
    );

    expect(screen.getByText(/Accueil/i)).toBeInTheDocument();
    expect(screen.getByText(/Offres/i)).toBeInTheDocument();
    expect(screen.getByText(/Panier/i)).toBeInTheDocument();
    expect(screen.getByText(/Déconnexion/i)).toBeInTheDocument();
    expect(screen.queryByText(/Connexion/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Inscription/i)).not.toBeInTheDocument();
  });

  test('affiche les liens admin si l\'utilisateur est admin', () => {
    render(
      <AuthContext.Provider value={{ isAuthenticated: true, user: { role: 'admin' }, logout: jest.fn() }}>
        <BrowserRouter>
          <Navbar />
        </BrowserRouter>
      </AuthContext.Provider>
    );

    expect(screen.getByText(/Admin/i)).toBeInTheDocument();
  });

  test('appelle la fonction de déconnexion lorsqu\'on clique sur Déconnexion', () => {
    const mockLogout = jest.fn();
    render(
      <AuthContext.Provider value={{ isAuthenticated: true, user: { role: 'user' }, logout: mockLogout }}>
        <BrowserRouter>
          <Navbar />
        </BrowserRouter>
      </AuthContext.Provider>
    );

    const logoutButton = screen.getByText(/Déconnexion/i);
    fireEvent.click(logoutButton);
    expect(mockLogout).toHaveBeenCalled();
  });
});
