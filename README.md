# YZV 322E - Applied Data Engineering: dbt Core Presentation

**Student Name:** Çağan Çobanoğlu
**Student ID:** 150210315
**Course:** YZV 322E | Spring 2026
**Tool Assigned:** dbt Core

## 1. What is this tool?
dbt (data build tool) Core is an open-source command-line framework that allows data engineers and analysts to transform data in their warehouse using simple SQL statements. It handles the "T" (Transform) phase of the ELT pipeline, bringing software engineering best practices like modularity, version control, automated testing, and CI/CD to data modeling. In this project, dbt Core cleans raw Airbnb data and engineers features for an XGBoost machine learning model.

## 2. Prerequisites
To run this project smoothly, ensure your system meets the following requirements:
*   **OS:** Windows, macOS, or Linux
*   **Docker & Docker Compose:** Installed and running (Docker Desktop is recommended).
*   **Git:** To clone the repository.
*   **Python 3.x:** (Optional but recommended) to run a local web server for dbt documentation.
*   **Ports:** Port `5432` (PostgreSQL) and Port `8000` (Python HTTP server) must be free on your local machine.

## 3. Installation
Follow these exact steps to clone the repository and build the isolated Docker environment. This setup utilizes the official `dbt-postgres` image and provisions a local PostgreSQL database automatically.

```bash
# 1. Clone the repository
git clone https://github.com/itu-itis25-cobanoglu21/my-dbt-project

# 2. Navigate into the project folder
cd my-dbt-project

# 3. Start the PostgreSQL data warehouse and dbt-core container in the background
docker compose up -d

# 4. Enter the interactive shell of the dbt-core container
docker exec -it dbt_core bash
```

## 4. Running the Example
Once you are inside the dbt-core container (your terminal prompt should look like `root@...:/usr/app#`), execute the following commands in order to build and test the data pipeline:
```bash
# 1. Navigate to the dbt project directory
cd airbnb_dbt

# 2. Verify the connection to the PostgreSQL database
dbt debug

# 3. Load the raw Kaggle CSV file into the database as a table
dbt seed

# 4. Execute the SQL models to clean data and engineer features
dbt run

# 5. Run data quality tests (unique, not_null, and custom outlier checks)
dbt test

# 6. View the final reporting layer directly in the terminal
dbt show --select report_premium_stats

# 7. Generate the visual lineage graph and documentation
dbt docs generate
```

### Viewing the Documentation (Lineage Graph)
To view the interactive DAG (Directed Acyclic Graph) generated in the last step, open a **new** terminal on your local machine (outside the Docker container), navigate to the target folder, and start a local Python server:
```bash
# Navigate to the target directory containing the generated HTML
cd airbnb_dbt/target

# Start a local web server 
python -m http.server 8000
```
Open your web browser and go to `http://localhost:8000`. Click the green "Lineage Graph" icon in the bottom right corner to view the data pipeline.

## 5. Expected Output
When running `dbt show --select report_premium_stats`, you will see the aggregated results of our feature engineering directly in the terminal:
```text
17:20:49  Previewing node 'report_premium_stats':
| is_premium_listing | total_listings | average_price |
| ------------------ | -------------- | ------------- |
|                  1 |            499 |      8,290.99 |
|                  0 |           1225 |      6,764.28 |
```

When running `dbt run` and `dbt test`, you should expect a completely green output indicating all models were created and all data quality constraints passed:
```text
Completed successfully
Done. PASS=5 WARN=0 ERROR=0 SKIP=0 TOTAL=5
```

## 6. AI Usage Disclosure
*   **Tool Used:** Gemini 3.1 Pro
*   **Purpose:** Used as an interactive tutor to brainstorm presentation scenarios, debug PostgreSQL type casting and compilation errors (e.g., `integer out of range` and `invalid input syntax`), construct the `docker-compose.yml` environment, and format the README file structure. All SQL transformations and architectural logic were reviewed and verified manually.
