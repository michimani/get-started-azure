import traceback
from azure.appconfiguration import AzureAppConfigurationClient, ConfigurationSetting
from azure.core import exceptions


def list_config_settings(
    client: AzureAppConfigurationClient, label: str
) -> list[ConfigurationSetting] or None:
    items = client.list_configuration_settings(label_filter=label)
    settings = []
    for item in items:
        settings.append(item)

    return settings


def is_enabled_feature(
    client: AzureAppConfigurationClient, feature_name: str, label: str
) -> bool:
    key = ".appconfig.featureflag/{}".format(feature_name)

    try:
        feature_flag = client.get_configuration_setting(key=key, label=label)

        if feature_flag is None:
            return False

    except exceptions.ResourceNotFoundError:
        print("key: {}, label: {} is not found".format(key, label))
        return False

    except Exception:
        print(traceback.format_exc())
        return False

    return feature_flag.enabled
