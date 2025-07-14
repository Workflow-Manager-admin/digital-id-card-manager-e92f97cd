-- Minimal seed data for Digital ID Card Manager

-- Populate roles
INSERT INTO roles (name, description) VALUES
('admin', 'Administrator user'),
('user', 'Normal application user'),
('holder', 'User who holds a digital ID card');

-- Add a sample admin user (password hash is just "test" with bcrypt cost 12 for illustration)
INSERT INTO users (username, email, password_hash, full_name, role_id)
VALUES (
    'adminuser',
    'admin@example.com',
    '$2b$12$cU8R5z7jHDNSr8c71TAy8.Z2mEvEZFjbFi/fKa.huT3UPXSG83eUO',
    'Admin Person',
    (SELECT id FROM roles WHERE name = 'admin')
);

-- Add a sample holder user
INSERT INTO users (username, email, password_hash, full_name, role_id)
VALUES (
    'janedoe',
    'jane@example.com',
    '$2b$12$somesamplehashforjanedoe',
    'Jane Doe',
    (SELECT id FROM roles WHERE name = 'holder')
);

-- Create a digital ID card for Jane Doe
INSERT INTO digital_id_cards (card_number, holder_name, date_of_birth, address, phone, photo_url, created_by)
VALUES (
    'ID-20240001',
    'Jane Doe',
    '1990-05-01',
    '123 Main St, Springfield',
    '+1555000111',
    'https://dummyimage.com/100x100/cccccc/333333.jpg',
    (SELECT id FROM users WHERE username = 'adminuser')
);

-- Link Jane Doe user to her card, as primary
INSERT INTO id_card_links (user_id, card_id, is_primary)
VALUES (
    (SELECT id FROM users WHERE username = 'janedoe'),
    (SELECT id FROM digital_id_cards WHERE card_number = 'ID-20240001'),
    TRUE
);
