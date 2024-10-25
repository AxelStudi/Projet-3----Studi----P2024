// src/components/Cart/Cart.js

import React, { useContext, useState, useEffect } from 'react';
import styles from './Cart.module.css';
import { CartContext } from '../../context/CartContext';
import { AuthContext } from '../../context/AuthContext';
import api from '../../services/api';
import Billet from '../Billet/Billet';
import { Link } from 'react-router-dom';

const Cart = () => {
  const { cartItems, removeFromCart, clearCart } = useContext(CartContext);
  const { user } = useContext(AuthContext);
  const [isProcessing, setIsProcessing] = useState(false);
  const [ticketKey, setTicketKey] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    console.log("Contenu du panier au chargement:", cartItems);
  }, [cartItems]);

  // Générer une clé aléatoire pour la sécurité des billets
  const generateSecurityKey = () => {
    return Math.random().toString(36).substring(2, 15);
  };

  const handleCheckout = async () => {
    if (!user) {
      setError('Vous devez être connecté pour procéder au paiement.');
      return;
    }

    if (cartItems.length === 0) {
      setError('Votre panier est vide.');
      return;
    }

    setIsProcessing(true);
    setError('');

    try {
      const secondKey = generateSecurityKey(); // Générer la deuxième clé
      const response = await api.post('/checkout/', {
        items: cartItems.map(item => ({ id: item.id, quantity: item.quantity || 1 })),  // Envoyer les items
        secondKey: secondKey,
      });

      if (response.status === 201) {
        const { ticket_key } = response.data;
        console.log('Paiement réussi, billet généré:', ticket_key);
        setTicketKey(ticket_key);
        clearCart();
      } else {
        setError('Erreur lors du traitement de la commande. Veuillez réessayer.');
      }
    } catch (err) {
      console.error('Erreur lors du paiement:', err);
      setError('Erreur lors du paiement. Veuillez réessayer.');
    } finally {
      setIsProcessing(false);
    }
  };

  if (ticketKey) {
    return (
      <div className={styles.billetContainer}>
        <h2>Achat Réussi !</h2>
        <Billet ticketKey={ticketKey} />
        <Link to="/" className={styles.continueButton}>Retour à l'accueil</Link>
      </div>
    );
  }

  return (
    <div className={styles.cartContainer}>
      <h2>Votre Panier</h2>
      {cartItems.length === 0 ? (
        <p>Votre panier est vide. <Link to="/offers">Voir les offres disponibles</Link></p>
      ) : (
        <>
          <ul className={styles.cartList}>
            {cartItems.map(item => (
              <li key={item.id} className={styles.cartItem}>
                <div className={styles.itemDetails}>
                  <h3>{item.name}</h3>
                  <p>{item.description}</p>
                  <p>Prix : {item.price}€</p>
                </div>
                <button
                  className={styles.removeButton}
                  onClick={() => removeFromCart(item.id)}
                >
                  Supprimer
                </button>
              </li>
            ))}
          </ul>
          <div className={styles.totalSection}>
            <h3>Total : {cartItems.reduce((acc, item) => acc + parseFloat(item.price), 0)}€</h3>
            {error && <p className={styles.error}>{error}</p>}
            <button
              className={styles.checkoutButton}
              onClick={handleCheckout}
              disabled={isProcessing}
            >
              {isProcessing ? 'Traitement...' : 'Procéder au Paiement'}
            </button>
          </div>
        </>
      )}
    </div>
  );
};

export default Cart;
