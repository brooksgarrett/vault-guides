#!/usr/bin/env bash

sudo apt-get install -y unzip jq

cat << EOF > /etc/profile.d/vault.sh
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_SKIP_VERIFY=true
EOF

cd /tmp
sudo curl ${vault_url} -o /tmp/vault.zip

logger "Installing vault"
sudo unzip -o /tmp/vault.zip -d /usr/bin/


sudo cat << EOF > /lib/systemd/system/vault.service
[Unit]
Description=Vault Agent
Requires=network-online.target
After=network-online.target
[Service]
Restart=on-failure
PermissionsStartOnly=true
ExecStartPre=/sbin/setcap 'cap_ipc_lock=+ep' /usr/local/bin/vault
ExecStart=/usr/local/bin/vault server -config /etc/vault.d/config.hcl
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGTERM
User=vault
Group=vault
[Install]
WantedBy=multi-user.target
EOF


sudo cat << EOF > /etc/vault.d/config.hcl
storage "file" {
  path = "/opt/vault"
}
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}
seal "azurekeyvault" {
  tenant_id = "${tenant_id}"
  client_id = "${client_id}"
  client_secret = "${client_secret}"
  vault_name = "${vault_name}"
  key_name = "vault_key"
}
ui=true
EOF


sudo chmod 0664 /lib/systemd/system/vault.service
sudo systemctl daemon-reload
sudo chown -R vault:vault /etc/vault.d
sudo chmod -R 0644 /etc/vault.d/*

sudo systemctl enable vault
