"""Query BigQuery using the credentials of the VM's attached Service Account.

Install: pip install google-cloud-bigquery
"""

from google.cloud import bigquery

def run_query() -> None:
    # Application Default Credentials: no key file needed on a VM with an attached SA
    client = bigquery.Client()