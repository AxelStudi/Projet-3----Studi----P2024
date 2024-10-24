import React, { useEffect, useState } from 'react';
import api from '../../services/api';
import styles from './SalesStatistics.module.css';

const SalesStatistics = () => {
  const [salesData, setSalesData] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchSalesData = async () => {
      try {
        const response = await api.get('/admin/sales/');
        setSalesData(response.data);
      } catch (error) {
        setError('Erreur lors de la récupération des statistiques de ventes.');
      }
    };

    fetchSalesData();
  }, []);

  return (
    <div className={styles.salesContainer}>
      <h2>Statistiques de Ventes</h2>
      {error && <p className={styles.error}>{error}</p>}
      {salesData.length === 0 ? (
        <p>Aucune vente enregistrée pour le moment.</p>
      ) : (
        <table className={styles.salesTable}>
          <thead>
            <tr>
              <th>Offre</th>
              <th>Nombre de Ventes</th>
            </tr>
          </thead>
          <tbody>
            {salesData.map((data) => (
              <tr key={data.offer_id}>
                <td>{data.offer_name}</td>
                <td>{data.sales_count}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default SalesStatistics;
