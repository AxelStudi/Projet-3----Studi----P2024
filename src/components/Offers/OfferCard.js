// src/components/Offers/OfferCard.js

import React, { useContext } from 'react';
import styles from './OfferCard.module.css';
import { CartContext } from '../../context/CartContext';

const OfferCard = ({ offer }) => {
  const { addToCart } = useContext(CartContext);

  const handleAddToCart = () => {
    const cartItem = {
      id: offer.id,
      name: offer.title,
      description: offer.description,
      price: offer.price,
      quantity: 1,
    };
    addToCart(cartItem); // Ajouter l'offre au panier
  };

  return (
    <div className={styles.offerCard}>
      <h3>{offer.title}</h3>
      <p>{offer.description}</p>
      <p>Prix : {offer.price} €</p>
      <button className={styles.buyButton} onClick={handleAddToCart}>
        Acheter
      </button>
    </div>
  );
};

export default OfferCard;
