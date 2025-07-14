-- Digital ID Card Manager PostgreSQL Schema
-- Features: users (with authentication), digital ID cards, unique number linking
-- Role-based login REMOVED. All accounts are generic users.

-- CLEAN SLATE: Drop previous tables for dev/testing. Remove or comment in production.
DROP TABLE IF EXISTS id_card_links CASCADE;
DROP TABLE IF EXISTS digital_id_cards CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- USERS table (generic, no role distinction)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    email VARCHAR(128) NOT NULL UNIQUE,
    password_hash VARCHAR(256) NOT NULL,
    full_name VARCHAR(128),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- DIGITAL ID CARDS table (profile info, unique number)
CREATE TABLE digital_id_cards (
    id SERIAL PRIMARY KEY,
    card_number VARCHAR(32) NOT NULL UNIQUE,
    holder_name VARCHAR(128) NOT NULL,
    date_of_birth DATE,
    address TEXT,
    phone VARCHAR(32),
    photo_url TEXT,
    issued_date DATE NOT NULL DEFAULT CURRENT_DATE,
    expires_date DATE,
    created_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- HOLDER-CARD LINK table (many-to-many)
CREATE TABLE id_card_links (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    card_id INTEGER NOT NULL REFERENCES digital_id_cards(id) ON DELETE CASCADE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    linked_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, card_id)
);

-- One primary card per user
CREATE UNIQUE INDEX one_primary_card_per_user ON id_card_links(user_id) WHERE is_primary;

-- Updated_at triggers
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER users_updated_at BEFORE UPDATE ON users
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();

CREATE TRIGGER cards_updated_at BEFORE UPDATE ON digital_id_cards
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();

-- Useful indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_card_links_user ON id_card_links(user_id);
CREATE INDEX idx_cards_card_number ON digital_id_cards(card_number);
