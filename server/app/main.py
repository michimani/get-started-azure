from fastapi import FastAPI
from components.azure_client import init_app_configuration_client
from usecases.app_configure import list_config_settings, is_enabled_feature

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/config_settings")
def list_app_config_settings(label: str = ""):
    client = init_app_configuration_client()
    if client is None:
        return {"error": "client is None"}

    config_settings = list_config_settings(client, label)
    if config_settings is None:
        return {"error": "config_settings is not found"}

    return config_settings


@app.get("/feature")
def get_feature_flag(feature_name: str, label: str):
    client = init_app_configuration_client()
    if client is None:
        return {"error": "client is None"}

    return {"enabled": is_enabled_feature(client, feature_name, label)}
