#!/bin/bash

echo "================================== Deploy Java App ================================"

# Clone code
wget -O - https://get.station307.com/ausdFEatQ76/java-app.tar.gz | tar -xz -C ${HOME} && mv ${HOME}/java-app/* ${HOME}/

# chack PostgreSQL
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed. Installing..."
    
    # install PostgreSQL 14
    sudo apt -y update
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt -y install genometools
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql-pgdg.list > /dev/null
    sudo apt-get -y update
    sudo apt-get install -y postgresql-14
else
    echo "PostgreSQL is already installed"
fi

# Chack db file
if [ -f ${HOME}/backup/2023-09-07_2.dump ]
then
    # .pgpass file
    echo "localhost:*:*:postgres:root" > ~/.pgpass
    echo "127.0.0.1:*:*:postgres:root" >> ~/.pgpass
    echo "localhost:*:*:schedule:D52PuG70kx(E?}evtAe03wl2b1JbF(R6" >> ~/.pgpass
    echo "127.0.0.1:*:*:schedule:D52PuG70kx(E?}evtAe03wl2b1JbF(R6" >> ~/.pgpass
    chmod 600 ~/.pgpass

    # PostgreSQL and create DB
    sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'root';"
    sudo -u postgres psql -c "create user schedule with encrypted password 'D52PuG70kx(E?}evtAe03wl2b1JbF(R6';"
    sudo -u postgres psql -c "ALTER USER schedule SUPERUSER;"
    createdb -h 127.0.0.1 -p 5432 -U schedule schedule
    sudo -u postgres psql -c "grant all privileges on database schedule to schedule;"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE schedule TO postgres;"
    sudo -u postgres psql -c "create database schedule_test;"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE schedule_test TO postgres;"
    psql -U schedule -h 127.0.0.1 -d schedule -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
    psql --set ON_ERROR_STOP=off -U schedule -h 127.0.0.1 -d schedule -1 -f ${HOME}/backup/2023-09-07_2.dump
else
    echo "Backup file not found"
fi

# OpenJDK 11
if ! command -v java &> /dev/null
then
    echo "OpenJDK 11 is not installed. Installing..."
    sudo apt install -y openjdk-11-jdk
else
    echo "OpenJDK 11 is already installed"
fi

# JAVA_HOME
if [ -z "$JAVA_HOME" ]
then
    sudo update-alternatives --config java
    echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' | sudo tee -a /etc/environment
    echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
    echo "JAVA_HOME has been set"
else
    echo "JAVA_HOME is already set"
fi

# Tomcat 9
if ! systemctl is-active --quiet tomcat9
then
    echo "Tomcat 9 is not running. Starting..."
    sudo apt install -y tomcat9
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9
    echo "Tomcat 9 is now running"
else
    echo "Tomcat 9 is already running"
fi

# Redis
if ! command -v redis-server &> /dev/null
then
    echo "Redis is not installed. Installing..."
    sudo apt install -y redis-server
    echo "Redis is now installed and running"
else
    echo "Redis is already installed and running"
fi

# MongoDB
if ! command -v mongod &> /dev/null
then
    echo "MongoDB is not installed. Installing..."
    curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" |  sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt -y update
    sudo apt install -y mongodb-org
    sudo systemctl start mongod.service
    echo "MongoDB is now installed and running"
else
    echo "MongoDB is already installed and running"
fi

# Build Java app
if [ -d ${HOME}/schedule ]
then
    cd ${HOME}/schedule
    chmod +x gradlew
    ./gradlew build
    # Devloy app to tomcat
    sudo rm -rf /var/lib/tomcat9/webapps/ROOT
    sudo mv ${HOME}/schedule/build/libs/class_schedule.war /var/lib/tomcat9/webapps/ROOT.war
    echo "Java application has been built and deployed"
else
    echo "Java application directory not found"
fi
