import React, { createContext, useState, useEffect } from 'react';
import { jwtDecode } from 'jwt-decode';  // Import correct de jwtDecode
import api from '../services/api';

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
      try {
        const decoded = jwtDecode(token);
        setUser(decoded);
      } catch (error) {
        console.error('Invalid token:', error);
        localStorage.removeItem('token');
      }
    }
  }, []);

  // Utilise `email` au lieu de `username` pour le login suite à un bug
  const login = async (email, password) => {
    try {
      const response = await api.post('/token/', { username: email, password });
      const { access, refresh } = response.data;
      localStorage.setItem('token', access);
      const decoded = jwtDecode(access);
      setUser(decoded);
    } catch (error) {
      console.error('Login failed:', error.response ? error.response.data : error.message);
      throw error;
    }
  };

  const register = async (userData) => {
    try {
      const username = `${userData.first_name}${userData.last_name}`.toLowerCase();

      const response = await api.post('/register/', {
        username: username,
        first_name: userData.first_name,
        last_name: userData.last_name,
        email: userData.email,
        password: userData.password,
      });

      if (response.data.token) {
        const { token } = response.data;
        localStorage.setItem('token', token);
        const decoded = jwtDecode(token);
        setUser(decoded);
      } else {
        setUser(response.data);
      }
    } catch (error) {
      console.error('Registration failed:', error.response ? error.response.data : error.message);
      throw error;
    }
  };

  const logout = () => {
    localStorage.removeItem('token');
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ isAuthenticated: !!user, user, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  );
};
