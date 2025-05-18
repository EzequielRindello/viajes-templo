-- Create tables
CREATE TABLE trips (
  id SERIAL PRIMARY KEY,
  destination VARCHAR(255) NOT NULL,
  departure_date TIMESTAMP NOT NULL,
  return_date TIMESTAMP NOT NULL,
  total_seats INTEGER NOT NULL,
  seats_available INTEGER NOT NULL,
  cost_per_person DECIMAL(10, 2) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE participants (
  id SERIAL PRIMARY KEY,
  trip_id INTEGER REFERENCES trips(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(50),
  paid_amount DECIMAL(10, 2) DEFAULT 0,
  payment_complete BOOLEAN DEFAULT FALSE,
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
-- Create a view for trip summaries
CREATE VIEW trip_summaries AS
SELECT t.id,
  t.destination,
  t.departure_date,
  t.return_date,
  t.total_seats,
  t.seats_available,
  t.cost_per_person,
  COUNT(p.id) AS enrolled_count,
  SUM(p.paid_amount) AS total_paid,
  (
    COUNT(p.id) * t.cost_per_person - SUM(p.paid_amount)
  ) AS amount_remaining
FROM trips t
  LEFT JOIN participants p ON t.id = p.trip_id
GROUP BY t.id;
-- Tabla de administradores
CREATE TABLE administrators (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  -- Almacenará el hash bcrypt
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  last_login TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
-- Tabla de sesiones (opcional para manejo de sesiones)
CREATE TABLE sessions (
  id SERIAL PRIMARY KEY,
  administrator_id INTEGER REFERENCES administrators(id),
  session_token VARCHAR(255) UNIQUE NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);