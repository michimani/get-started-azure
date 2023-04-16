import os
from azure.identity import DefaultAzureCredential
from azure.appconfiguration import AzureAppConfigurationClient


def init_app_configuration_client() -> AzureAppConfigurationClient or None:
    endpoint = os.environ.get("APP_CONFIG_ENDPOINT", "")
    if len(endpoint) == 0:
        print("APP_CONFIG_ENDPOINT is not set")
        return None

    credential = DefaultAzureCredential()

    return AzureAppConfigurationClient(base_url=endpoint, credential=credential)
