// src/components/Navbar/Navbar.js

import React, { useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { AuthContext } from '../../context/AuthContext';
import { CartContext } from '../../context/CartContext';
import styles from './Navbar.module.css';

const Navbar = () => {
  const { isAuthenticated, user, logout } = useContext(AuthContext);
  const { cartItems } = useContext(CartContext);
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  return (
    <nav className={styles.navbar}>
      <div className={styles.logo}>
        <Link to="/">JO 2024</Link>
      </div>
      <ul className={styles.navLinks}>
        <li>
          <Link to="/">Accueil</Link>
        </li>
        <li>
          <Link to="/offers">Offres</Link>
        </li>
        {isAuthenticated && (
          <li>
            <Link to="/cart">Panier ({cartItems.length})</Link>
          </li>
        )}
        {isAuthenticated ? (
          <>
            {user.role === 'admin' && (
              <li>
                <Link to="/admin">Admin</Link>
              </li>
            )}
            <li>
              <button onClick={handleLogout} className={styles.logoutButton}>
                Déconnexion
              </button>
            </li>
          </>
        ) : (
          <>
            <li>
              <Link to="/login">Connexion</Link>
            </li>
            <li>
              <Link to="/register">Inscription</Link>
            </li>
          </>
        )}
      </ul>
    </nav>
  );
};

export default Navbar;
