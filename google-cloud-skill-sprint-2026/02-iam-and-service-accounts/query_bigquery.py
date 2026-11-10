"""Query BigQuery using the credentials of the VM's attached Service Account.

Install: pip install google-cloud-bigquery
"""

from google.cloud import bigquery

def run_query() -> None:
    # Application Default Credentials: no key file needed on a VM with an attached SA
    client = bigquery.Client()
    query = """
        SELECT name, SUM(number) AS total_count
        FROM `bigquery-public-data.usa_names.usa_1910_2013`
        GROUP BY name
        ORDER BY total_count DESC
        LIMIT 5
    """
    for row in client.query(query).result():
        print(f"{row.name}: {row.total_count}")