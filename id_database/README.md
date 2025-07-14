# Digital ID Card Manager Database (id_database)

This directory contains the PostgreSQL schema, seed data, and automation scripts for initializing the Digital ID Card Manager database.

## 🟢 PostgreSQL Environment Variables

The backend API and any DB visualizer tools use these environment variables:

| Variable           | Purpose                       | Example                            |
|--------------------|------------------------------|------------------------------------|
| POSTGRES_URL       | PostgreSQL connection string  | postgresql://localhost:5000/myapp  |
| POSTGRES_USER      | DB user                      | appuser                            |
| POSTGRES_PASSWORD  | DB password                  | dbuser123                          |
| POSTGRES_DB        | DB name                      | myapp                              |
| POSTGRES_PORT      | Port (default: 5000)         | 5000                               |

These variables are preset in `db_visualizer/postgres.env`.

- For Docker/local development, copy `.env.example` to `.env` and edit as needed.
- Backend API containers should also import these same variable names for a direct connection.

## 🏗️ Schema/Migration

1. **Create or reset** your database (see `startup.sh`).
2. Run `schema.sql` to create all tables:
    ```bash
    psql $POSTGRES_URL -f schema.sql
    ```
3. Optionally, load test users/cards:
    ```bash
    psql $POSTGRES_URL -f seed_data.sql
    ```

You can automate this by using the `startup.sh` script for local/dev usage:
```bash
bash startup.sh
```

## 🗄️ Tables Overview

- **users**: Auth credentials and profile info
- **digital_id_cards**: Card records, each linked to a creator; all cards have a unique number
- **id_card_links**: Links users to cards (for primary/secondary/legacy links etc.)

Schema details and all constraints are inline documented in `schema.sql`.

## 🟦 Environment Integration

- Environment variables are required by backend (Flask API) and DB visualizer.
- The default configuration is stored in `db_visualizer/postgres.env`.
- Copy these to your backend or CI environment as needed.

## 📎 Example Connections

```bash
psql postgresql://appuser:dbuser123@localhost:5000/myapp
source db_visualizer/postgres.env
psql "$POSTGRES_URL"
```

## 🛠️ Bootstrapping: `startup.sh`

The provided `startup.sh` script will:
- Detect local PostgreSQL installation/version
- Create/start the DB on the configured port (default: 5000)
- Create user and assign permissions
- Apply environment variable config
- Save a one-line connection string in `db_connection.txt`

> **Note**: The included table drops in `schema.sql` are for dev/test use ONLY! Remove/comment those lines in production to preserve existing data.

---

For full-stack integration, make sure backend and frontend `.env` files match these variables.

