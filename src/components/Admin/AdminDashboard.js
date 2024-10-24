import React from 'react';
import { Link } from 'react-router-dom';
import styles from './AdminDashboard.module.css';

const AdminDashboard = () => {
  return (
    <div className={styles.dashboardContainer}>
      <h2>Tableau de Bord Administrateur</h2>
      <div className={styles.dashboardLinks}>
        <Link to="/admin/manage-offers" className={styles.dashboardLink}>Gérer les Offres</Link>
        <Link to="/admin/sales" className={styles.dashboardLink}>Statistiques de Ventes</Link>
      </div>
    </div>
  );
};

export default AdminDashboard;
