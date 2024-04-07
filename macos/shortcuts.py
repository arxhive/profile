import os
import sys
import json
from argparse import ArgumentParser

# pip install pyobjc
from AppKit import NSUserDefaults

defaults = NSUserDefaults.standardUserDefaults()
allDomains = defaults.persistentDomainNames()
global_defaults_name = "pbs"
global_defaults = defaults.persistentDomainForName_(global_defaults_name)
filename = os.path.join(os.path.dirname(__file__), "mac-shortcuts.json")
NSUserKeyEquivalents = "NSUserKeyEquivalents"


def save():
    apps = []

    for domainName in allDomains:
        domain = defaults.persistentDomainForName_(domainName) or {}
        keys = domain.get(NSUserKeyEquivalents)
        if keys:
            apps.append(
                {
                    "domainName": domainName,
                    "keys": [
                        {"action": action, "key": key} for action, key in keys.items()
                    ],
                }
            )

    services = []

    for key, value in global_defaults.get("NSServicesStatus", {}).items():
        if "key_equivalent" in value:
            services.append({"action": key, "key": value.get("key_equivalent")})

    with open(filename, "w") as f:
        json.dump({"app": apps, "service": services}, f, indent=2)


def load():
    with open(filename, "r") as f:
        configuration = json.load(f)

    for app in configuration["app"]:
        key_equivalents = {
            NSUserKeyEquivalents: {each["action"]: each["key"] for each in app["keys"]}
        }
        defaults.setPersistentDomain_forName_(key_equivalents, app["domainName"])

    services = {
        "NSServicesStatus": {each["action"]: {"key_equivalent": each["key"]}}
        for each in configuration["service"]
    }
    defaults.setPersistentDomain_forName_(services, global_defaults_name)


parser = ArgumentParser()
parser.set_defaults(func=parser.print_usage)
sub = parser.add_subparsers()
sub.add_parser("save").set_defaults(func=save)
sub.add_parser("load").set_defaults(func=load)
parser.parse_args(sys.argv[1:]).func()
