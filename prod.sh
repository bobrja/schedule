#!/bin/bash

# Install PostgreSQL 14
sudo apt -y update
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt -y install genometools
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql-pgdg.list > /dev/null
sudo apt-get -y update
sudo apt-get install -y postgresql-14

# Create .pgpass file
echo "localhost:*:*:postgres:root" > ~/.pgpass
echo "127.0.0.1:*:*:postgres:root" >> ~/.pgpass
echo "localhost:*:*:schedule:D52PuG70kx(E?}evtAe03wl2b1JbF(R6" >> ~/.pgpass
echo "127.0.0.1:*:*:schedule:D52PuG70kx(E?}evtAe03wl2b1JbF(R6" >> ~/.pgpass
chmod 600 ~/.pgpass

# Set PostgreSQL passwords and create databases
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'root';"
sudo -u postgres psql -c "create user schedule with encrypted password 'D52PuG70kx(E?}evtAe03wl2b1JbF(R6';"
sudo -u postgres psql -c "ALTER USER schedule SUPERUSER;"
createdb -h 127.0.0.1 -p 5432 -U schedule schedule
sudo -u postgres psql -c "grant all privileges on database schedule to schedule;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE schedule TO postgres;"
sudo -u postgres psql -c "create database schedule_test;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE schedule_test TO postgres;"
psql -U schedule -h 127.0.0.1 -d schedule -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
psql --set ON_ERROR_STOP=off -U schedule -h 127.0.0.1 -d schedule -1 -f /home/bobrja/backup/2023-09-07_2.dump

# Install Java 11
sudo apt install -y openjdk-11-jdk

# Set JAVA_HOME Environment Variable
sudo update-alternatives --config java
echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' | sudo tee -a /etc/environment
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install Tomcat 9
sudo apt install -y tomcat9
sudo systemctl start tomcat9
sudo systemctl enable tomcat9

# Install Redis
sudo apt install -y redis-server

# Install MongoDB
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt -y update
sudo apt install -y mongodb-org
sudo systemctl start mongod.service

# Build your Java application
cd /home/bobrja/schedule
chmod +x gradlew
./gradlew build

# Deploy your application to Tomcat
sudo rm -rf /var/lib/tomcat9/webapps/ROOT
sudo mv /home/bobrja/schedule/build/libs/class_schedule.war /var/lib/tomcat9/webapps/ROOT.war

