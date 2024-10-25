import React, { useState, useContext } from 'react';
import { AuthContext } from '../../context/AuthContext';
import { useNavigate, Link } from 'react-router-dom';
import styles from './Login.module.css';

const Login = () => {
  const { login } = useContext(AuthContext);
  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    try {
      await login(email, password);
      navigate('/');
    } catch (error) {
      setError('Échec de la connexion. Veuillez vérifier vos identifiants.');
    }
  };

  return (
    <div className={styles.loginContainer}>
      <h2>Connexion</h2>
      <form onSubmit={handleSubmit} className={styles.loginForm}>
        {error && <p className={styles.error}>{error}</p>}
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
        </div>
        <button type="submit" className={styles.submitButton}>Se connecter</button>
      </form>
      <p className={styles.redirect}>
        Pas encore de compte ? <Link to="/register">Inscrivez-vous</Link>
      </p>
    </div>
  );
};

export default Login;
