import React, { useEffect, useState } from 'react';
import api from '../../services/api';
import styles from './ManageOffers.module.css';

const ManageOffers = () => {
  const [offers, setOffers] = useState([]);
  const [newOffer, setNewOffer] = useState({ name: '', description: '', price: '', type: '' });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    const fetchOffers = async () => {
      try {
        const response = await api.get('/offers/');
        setOffers(response.data);
      } catch (error) {
        setError('Erreur lors de la récupération des offres.');
      }
    };

    fetchOffers();
  }, []);

  const handleChange = (e) => {
    setNewOffer({ ...newOffer, [e.target.name]: e.target.value });
  };

  const handleAddOffer = async (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    try {
      await api.post('/offers/', newOffer);
      setNewOffer({ name: '', description: '', price: '', type: '' });
      setSuccess('Offre ajoutée avec succès !');
      // Rafraîchir la liste des offres
      const response = await api.get('/offers/');
      setOffers(response.data);
    } catch (error) {
      setError('Erreur lors de l\'ajout de l\'offre.');
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Êtes-vous sûr de vouloir supprimer cette offre ?')) return;
    try {
      await api.delete(`/offers/${id}/`);
      setOffers(offers.filter(offer => offer.id !== id));
      setSuccess('Offre supprimée avec succès !');
    } catch (error) {
      setError('Erreur lors de la suppression de l\'offre.');
    }
  };

  return (
    <div className={styles.manageOffersContainer}>
      <h2>Gérer les Offres</h2>
      {error && <p className={styles.error}>{error}</p>}
      {success && <p className={styles.success}>{success}</p>}
      <form onSubmit={handleAddOffer} className={styles.offerForm}>
        <div className={styles.formGroup}>
          <label htmlFor="name">Nom :</label>
          <input
            type="text"
            id="name"
            name="name"
            value={newOffer.name}
            onChange={handleChange}
            required
            placeholder="Nom de l'offre"
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="description">Description :</label>
          <textarea
            id="description"
            name="description"
            value={newOffer.description}
            onChange={handleChange}
            required
            placeholder="Description de l'offre"
          ></textarea>
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="price">Prix (€) :</label>
          <input
            type="number"
            id="price"
            name="price"
            value={newOffer.price}
            onChange={handleChange}
            required
            min="0"
            step="0.01"
            placeholder="Prix de l'offre"
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="type">Type :</label>
          <select
            id="type"
            name="type"
            value={newOffer.type}
            onChange={handleChange}
            required
          >
            <option value="">Sélectionner</option>
            <option value="solo">Solo</option>
            <option value="duo">Duo</option>
            <option value="familial">Familial</option>
          </select>
        </div>
        <button type="submit" className={styles.submitButton}>Ajouter l'Offre</button>
      </form>

      <h3>Liste des Offres</h3>
      <table className={styles.offerTable}>
        <thead>
          <tr>
            <th>Nom</th>
            <th>Description</th>
            <th>Prix (€)</th>
            <th>Type</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {offers.map(offer => (
            <tr key={offer.id}>
              <td>{offer.name}</td>
              <td>{offer.description}</td>
              <td>{offer.price}</td>
              <td>{offer.type.charAt(0).toUpperCase() + offer.type.slice(1)}</td>
              <td>
                <button onClick={() => handleDelete(offer.id)} className={styles.deleteButton}>Supprimer</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default ManageOffers;
