import React, { useState, useContext } from 'react';
import { AuthContext } from '../../context/AuthContext';
import { useNavigate, Link } from 'react-router-dom';
import styles from './Register.module.css';

const Register = () => {
  const { register } = useContext(AuthContext);
  const navigate = useNavigate();

  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault(); // Empêche le rechargement de la page
    setError('');

    // Générer le username automatiquement à partir de firstName et lastName
    const username = `${firstName}${lastName}`.toLowerCase();

    try {
      await register({
        username,
        first_name: firstName,
        last_name: lastName,
        email,
        password,
      });
      navigate('/');
    } catch (error) {
      if (error.response && error.response.data) {
        setError(error.response.data.detail || 'Une erreur est survenue lors de l\'inscription.');
      } else {
        setError('Erreur réseau. Veuillez réessayer.');
      }
    }
  };

  return (
    <div className={styles.registerContainer}>
      <h2>Inscription</h2>
      <form onSubmit={handleSubmit} className={styles.registerForm}>
        {error && <p className={styles.error}>{error}</p>}
        <div className={styles.formGroup}>
          <label htmlFor="firstName">Prénom :</label>
          <input
            type="text"
            id="firstName"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            required
            placeholder="Votre prénom"
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="lastName">Nom :</label>
          <input
            type="text"
            id="lastName"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            required
            placeholder="Votre nom"
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="email">Email :</label>
          <input
            type="email"
            id="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            placeholder="Votre email"
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="password">Mot de passe :</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            placeholder="Votre mot de passe"
          />
          <small>Minimum 8 caractères, incluant lettres, chiffres et caractères spéciaux.</small>
        </div>
        <button type="submit" className={styles.submitButton}>S'inscrire</button>
      </form>
      <p className={styles.redirect}>
        Déjà un compte ? <Link to="/login">Connectez-vous</Link>
      </p>
    </div>
  );
};

export default Register;
