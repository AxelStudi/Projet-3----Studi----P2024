// src/components/Offers/OfferList.js

import React, { useEffect, useState } from 'react';
import OfferCard from './OfferCard';
import styles from './OfferList.module.css';
import axios from 'axios';

const OfferList = () => {
  const [offers, setOffers] = useState([]);

useEffect(() => {
  axios.get('http://localhost:8000/api/offers')  // Utilisez l'URL complète ici
    .then((response) => {
      setOffers(response.data);
    })
    .catch((error) => {
      console.error('Error fetching offers:', error);
    });
}, []);


  return (
    <div className={styles.offerListContainer}>
      <h2>Offres Disponibles</h2>
      <div className={styles.offerGrid}>
        {offers.map((offer) => (
          <OfferCard key={offer.id} offer={offer} />
        ))}
      </div>
    </div>
  );
};

export default OfferList;
