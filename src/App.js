// src/App.js

import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Navbar from './components/Navbar/Navbar';
import Home from './components/Home/Home';
import OfferList from './components/Offers/OfferList';
import Login from './components/Auth/Login';
import Register from './components/Auth/Register';
import Cart from './components/Cart/Cart';
import AdminDashboard from './components/Admin/AdminDashboard';
import ManageOffers from './components/Admin/ManageOffers';
import SalesStatistics from './components/Admin/SalesStatistics';
import PrivateRoute from './components/PrivateRoute';
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext';
import './assets/styles/shared.css';

function App() {
  return (
    <AuthProvider>
      <CartProvider>
        <Router>
          <Navbar />
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/offers" element={<OfferList />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/cart" element={<PrivateRoute><Cart /></PrivateRoute>} />
            <Route path="/admin" element={<PrivateRoute admin><AdminDashboard /></PrivateRoute>} />
            <Route path="/admin/manage-offers" element={<PrivateRoute admin><ManageOffers /></PrivateRoute>} />
            <Route path="/admin/sales" element={<PrivateRoute admin><SalesStatistics /></PrivateRoute>} />
            {/* Les autres routes ici, mais bon, normalement tout y est */}
          </Routes>
        </Router>
      </CartProvider>
    </AuthProvider>
  );
}

export default App;
