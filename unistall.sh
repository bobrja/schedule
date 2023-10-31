#!/bin/bash

# Uninstall Java
echo "Uninstalling Java..."
sudo apt purge -y openjdk-11-jdk
sudo apt autoremove -y
sudo apt clean
sudo rm -rf /usr/lib/jvm/java-11-openjdk-amd64
sudo sed -i '/JAVA_HOME/d' /etc/environment
sed -i '/JAVA_HOME/d' ~/.bashrc
source ~/.bashrc
echo "Java has been uninstalled"

# Uninstall PostgreSQL
echo "Uninstalling PostgreSQL..."
sudo -u postgres psql -c "DROP DATABASE IF EXISTS schedule;"
sudo -u postgres psql -c "DROP DATABASE IF EXISTS schedule_test;"
sudo -u postgres psql -c "DROP USER IF EXISTS schedule;"
sudo -u postgres psql -c "ALTER USER postgres PASSWORD NULL;"
sudo apt purge -y postgresql-14
sudo apt autoremove -y
sudo apt clean
sudo rm /etc/apt/sources.list.d/postgresql-pgdg.list
echo "PostgreSQL has been uninstalled"

# Uninstall Tomcat
echo "Uninstalling Tomcat..."
sudo systemctl stop tomcat9
sudo systemctl disable tomcat9
sudo apt purge -y tomcat9
sudo apt autoremove -y
sudo apt clean
echo "Tomcat has been uninstalled"

# Uninstall Redis
echo "Uninstalling Redis..."
sudo apt purge -y redis-server
sudo apt autoremove -y
sudo apt clean
echo "Redis has been uninstalled"

# Uninstall MongoDB
echo "Uninstalling MongoDB..."
sudo systemctl stop mongod
sudo apt purge -y mongodb-org
sudo apt autoremove -y
sudo apt clean
sudo rm /etc/apt/sources.list.d/mongodb-org-4.4.list
echo "MongoDB has been uninstalled"

# Remove application and project files
if [ -d ~/schedule ]
then
    echo "Removing the project directory..."
    rm -rf ~/schedule
fi

if [ -f /var/lib/tomcat9/webapps/ROOT.war ]
then
    echo "Removing the deployed Java application..."
    sudo rm -f /var/lib/tomcat9/webapps/ROOT.war
fi

echo "Uninstallation complete"
