// src/components/Billet/Billet.js

import React from 'react';
import { QRCodeSVG } from 'qrcode.react'; // Import nommé
import styles from './Billet.module.css';

const Billet = ({ ticketKey }) => {
  return (
    <div className={styles.billet}>
      <h3>Votre e-Billet</h3>
      <QRCodeSVG value={ticketKey} size={256} />
      <p>Scannez ce QR Code le jour des Jeux Olympiques pour valider votre billet.</p>
    </div>
  );
};

export default Billet;
