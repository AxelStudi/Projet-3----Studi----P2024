// jest.config.js
module.exports = {
  transform: {
    '^.+\\.jsx?$': 'babel-jest',
  },
  transformIgnorePatterns: [
    '/node_modules/(?!(axios)/)', // Assurez-vous que axios est inclus pour la transformation
  ],
  moduleFileExtensions: ['js', 'jsx', 'json', 'node'],
};
