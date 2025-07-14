# digital-id-card-manager-e92f97cd

## PostgreSQL Environment Variables

The backend API and database tools use the following environment variables for PostgreSQL connection:

- **POSTGRES_URL** (example: `postgresql://localhost:5000/myapp`)
- **POSTGRES_USER** (example: `appuser`)
- **POSTGRES_PASSWORD** (example: `dbuser123`)
- **POSTGRES_DB** (example: `myapp`)
- **POSTGRES_PORT** (example: `5000`)

These are pre-set in `id_database/db_visualizer/postgres.env` and used by the backend for secure DB connections.

## Schema Migration

1. Run `schema.sql` in your PostgreSQL instance to set up DB tables.
2. (Optional) Run `seed_data.sql` to add default roles and a test user/card.

## Core Tables

- **roles**: role-based access control (admin, user, holder, etc.)
- **users**: user credentials and profile info (FK to roles)
- **digital_id_cards**: profile and card info (unique card number)
- **id_card_links**: mapping/link table connecting holders to their cards

Refer to the comments in `schema.sql` for field details.