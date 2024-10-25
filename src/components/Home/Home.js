import React from 'react';
import { Link } from 'react-router-dom';
import './Home.css';
import olympicStadium from '../../assets/images/olympic-stadium.jpg';
import athletes from '../../assets/images/athletes.jpg';
import parisMap from '../../assets/images/paris-map.jpg';

const Home = () => {
  return (
    <div className="home-container">
      {/* Section de Bienvenue */}
      <section className="welcome-section">
        <h1>Bienvenue aux Jeux Olympiques Paris 2024</h1>
        <img src={olympicStadium} alt="Stade Olympique" className="responsive-image" />
        <p>
          Les Jeux Olympiques de Paris 2024 marquent le retour tant attendu des JO en France. Cet événement mondial réunira des athlètes de tous horizons pour célébrer l'excellence sportive et l'esprit de compétition.
        </p>
        <Link to="/offers" className="cta-button">Réservez vos e-tickets dès maintenant</Link>
      </section>

      {/* Section Présentation des JO */}
      <section className="about-section">
        <h2>À propos des JO Paris 2024</h2>
        <div className="about-content">
          <img src={athletes} alt="Athlètes Olympiques" className="responsive-image" />
          <div className="about-text">
            <p>
              Paris 2024 promet d'être un événement inoubliable, avec des sites emblématiques tels que le Stade de France, le Grand Palais, et le Champ de Mars servant de lieux de compétition. Les organisateurs mettent un point d'honneur à allier tradition et innovation pour offrir une expérience exceptionnelle aux spectateurs.
            </p>
            <p>
              Cette édition des Jeux Olympiques mettra également l'accent sur la durabilité et l'accessibilité, en intégrant des technologies modernes pour faciliter la réservation et la validation des billets, tout en garantissant la sécurité de tous les participants.
            </p>
          </div>
        </div>
      </section>

      {/* Section Épreuves Principales */}
      <section className="events-section">
        <h2>Épreuves Principales</h2>
        <div className="events-grid">
          <div className="event-card">
            <h3>Athlétisme</h3>
            <img src="https://source.unsplash.com/400x300/?athletics" alt="Athlétisme" className="responsive-image" />
            <p>Découvrez les performances exceptionnelles des athlètes dans diverses disciplines d'athlétisme.</p>
          </div>
          <div className="event-card">
            <h3>Natation</h3>
            <img src="https://source.unsplash.com/400x300/?swimming" alt="Natation" className="responsive-image" />
            <p>Assistez aux compétitions de natation où vitesse et technique sont à l'honneur.</p>
          </div>
          <div className="event-card">
            <h3>Gymnastique</h3>
            <img src="https://source.unsplash.com/400x300/?gymnastics" alt="Gymnastique" className="responsive-image" />
            <p>Admirez la grâce et la puissance des gymnastes sur les agrès.</p>
          </div>
          <div className="event-card">
            <h3>Cyclisme</h3>
            <img src="https://source.unsplash.com/400x300/?cycling" alt="Cyclisme" className="responsive-image" />
            <p>Vivez l'intensité des courses cyclistes à travers les rues de Paris.</p>
          </div>
        </div>
      </section>

      {/* Section Carte de Paris */}
      <section className="map-section">
        <h2>Carte des Sites Olympiques</h2>
        <img src={parisMap} alt="Carte des Sites Olympiques" className="responsive-image" />
        <p>
          Explorez les différents sites de compétition et découvrez comment vous rendre à chaque événement grâce à notre carte interactive.
        </p>
      </section>

      {/* Section Témoignages */}
      <section className="testimonials-section">
        <h2>Témoignages</h2>
        <div className="testimonials">
          <div className="testimonial">
            <p>"Participer aux JO de Paris 2024 a été une expérience incroyable. L'organisation est impeccable et les sites sont magnifiques."</p>
            <h4>— Marie Dupont</h4>
          </div>
          <div className="testimonial">
            <p>"La réservation des billets en ligne a été simple et sécurisée. Je recommande vivement ce système."</p>
            <h4>— Jean Martin</h4>
          </div>
          <div className="testimonial">
            <p>"Les e-tickets ont facilité mon accès aux événements. C'est un système moderne et efficace."</p>
            <h4>— Sophie Leroy</h4>
          </div>
        </div>
      </section>

      {/* Section Contact */}
      <section className="contact-section">
        <h2>Contactez-nous</h2>
        <p>
          Pour toute question ou assistance, n'hésitez pas à nous contacter via notre <Link to="/contact">page de contact</Link>.
        </p>
      </section>

      {/* Attribution des Images */}
      <footer className="image-attribution">
        <p>
          <strong>Sources des Images :</strong>
          <br />
          <a href="https://unsplash.com/photos/stadium" target="_blank" rel="noopener noreferrer">Stade Olympique - Unsplash</a>
          <br />
          <a href="https://unsplash.com/photos/athletes" target="_blank" rel="noopener noreferrer">Athlètes Olympiques - Unsplash</a>
          <br />
          <a href="https://unsplash.com/photos/paris-map" target="_blank" rel="noopener noreferrer">Carte de Paris - Unsplash</a>
        </p>
      </footer>
    </div>
  );
};

export default Home;
