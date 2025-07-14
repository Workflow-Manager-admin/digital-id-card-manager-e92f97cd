# digital-id-card-manager-e92f97cd

PostgreSQL Database for Digital ID Card Manager.

---

## 🟢 PostgreSQL Environment Variables

The backend API and any database visualizer tools use these environment variables for DB connection:

| Variable         | Purpose                                | Example                            |
|------------------|----------------------------------------|------------------------------------|
| POSTGRES_URL     | PostgreSQL host/address                | postgresql://localhost:5000/myapp  |
| POSTGRES_USER    | DB user                                | appuser                            |
| POSTGRES_PASSWORD| DB password                            | dbuser123                          |
| POSTGRES_DB      | DB name                                | myapp                              |
| POSTGRES_PORT    | Port (default: 5000)                   | 5000                               |

- These are preset in `id_database/db_visualizer/postgres.env`
- Also copied into `id_backend_api/.env` for the Flask API backend.

---

## 🏗️ Schema Migration

1. Run `id_database/schema.sql` in your PostgreSQL instance to initialize tables.
2. Optionally, load `seed_data.sql` for test users/cards.

_Tip:_ Use `startup.sh` to automate DB/user/schema creation (see script output for connection info).

---

## 🗄️ Core Tables

- **users**: Auth credentials and profile info (single generic type; no roles)
- **digital_id_cards**: Digital card and holder info (holder, number, etc.)
- **id_card_links**: Links users to cards (used for primary card relationship)

See comments in `schema.sql` for full details and constraints.

---

## 🔗 Full Stack Integration

- **Backend** connects using the environment vars above.
- **Frontend** calls backend using its own environment (`REACT_APP_API_URL`).
- End-to-end integration is achieved by ensuring all env files match and all services are reachable!

---

## 📎 Example Connection

```bash
psql postgresql://appuser:dbuser123@localhost:5000/myapp
```

or use the prepared variables:

```bash
export $(cat db_visualizer/postgres.env | xargs)
```

---

