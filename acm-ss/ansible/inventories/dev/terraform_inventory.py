#!/usr/bin/env python3

import json
import subprocess
import os

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
TERRAFORM_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "../../../terraform/envs/dev"))

cmd = ["terraform", "output", "-json"]
result = subprocess.check_output(cmd, cwd=TERRAFORM_DIR)
tf_outputs = json.loads(result)

inventory = {
    "_meta": {"hostvars": {}}
}

for output_name, output_value in tf_outputs.items():

    if output_name.endswith("_public_ips"):


        group_name = output_name.replace("_public_ips", "")

        inventory[group_name] = {
            "hosts": output_value["value"]
        }

print(json.dumps(inventory))