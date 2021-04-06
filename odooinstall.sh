#Paso 1: Actualizar el servidor
sudo apt-get update
sudo apt-get upgrade -y
#Paso 2: crear un usuario de Odoo en Ubuntu
sudo adduser -system -home=/opt/odoo -group odoo
#Paso 3: instalar PostgreSQL Server
sudo apt-get install postgresql -y
#Paso 4: crear un usuario de Odoo para PostgreSQL
sudo su - postgres -c "createuser -s odoo" 2> /dev/null || true
#Paso 5: instalar las dependencias de Python
sudo apt-get install git python3 python3-pip build-essential wget python3-dev python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev gdebi -y
#Paso 6: instalar las dependencias de Python PIP
sudo apt-get install libpq-dev python-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev
sudo -H pip3 install -r https://raw.githubusercontent.com/odoo/odoo/master/requirements.txt
#Paso 7: instale otros paquetes necesarios
sudo apt-get install nodejs npm -y
sudo npm install -g rtlcss
#Paso 8: Instale Wkhtmltopdf
sudo apt-get install xfonts-75dpi
sudo wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.6-1.bionic_amd64.deb
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
#Paso 9: crear directorio de registro
sudo mkdir /var/log/odoo
sudo chown odoo:odoo /var/log/odoo
#Paso 10: instala Odoo
sudo apt-get install git
sudo git clone --depth 1 --branch master https://www.github.com/odoo/odoo /odoo/odoo-server
#Paso 11: configuración de permisos en la carpeta de inicio
sudo chown -R odoo:odoo /odoo/*
#Paso 12: Cree el archivo de configuración del servidor
sudo touch /etc/odoo-server.conf
sudo su root -c "printf '[options] \n; This is the password that allows database operations:\n' >> /etc/odoo-server.conf" 
sudo su root -c "printf 'admin_passwd = admin\n' >> /etc/odoo-server.conf"
sudo su root -c "printf 'xmlrpc_port = 8069\n' >> /etc/odoo-server.conf" 
sudo su root -c "printf 'logfile = /var/log/odoo/odoo-server.log\n' >> /etc/odoo-server.conf" 
sudo su root -c "printf 'addons_path=/odoo/odoo-server/addons\n' >> /etc/odoo-server.conf" 
sudo chown odoo:odoo /etc/odoo-server.conf 
sudo chmod 640 /etc/odoo-server.conf 
#Paso 13: Ahora inicia Odoo
sudo su - odoo -s /bin/bash
cd /odoo/odoo-server
./odoo-bin -c /etc/odoo-server.conf





