#!/bin/bash

echo "==================================================================================="
echo "================================== Deploy Java App ================================"
echo "==================================================================================="

[ ! -f .env ] || export $(grep -v '^#' .env | xargs)

# Clone code
echo "==================================================================================="
echo "Clone GitHub Repo ..."
echo "==================================================================================="
git clone https://github.com/bobrja/schedule.git ${HOME}/${DIR_PROJECT} 

# Заміна паролю в файлі hibernate.properties
sed -i "s/hibernate.connection.password=.*/hibernate.connection.password=${PG_SCHEDULE_PASSWORD}/" ${HOME}/${DIR_PROJECT}/src/main/resources/hibernate.properties
sed -i "s/hibernate.connection.password=.*/hibernate.connection.password=${PG_PASSWORD}/" ${HOME}/${DIR_PROJECT}/src/test/resources/hibernatetest.properties

# chack PostgreSQL
if ! command -v psql &> /dev/null
then
    echo "==================================================================================="
    echo "PostgreSQL is not installed. Installing..."
    echo "==================================================================================="

    
    # install PostgreSQL 14
    sudo apt -y update
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt -y install genometools
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql-pgdg.list > /dev/null
    sudo apt-get -y update
    sudo apt-get install -y postgresql-14
else
    echo "==================================================================================="
    echo "PostgreSQL is already installed"
    echo "==================================================================================="
fi

# Chack db file
if [ -f ${HOME}/${DIR_PROJECT}/backup/2023-09-07_2.dump ]
then
    # .pgpass file
    echo "localhost:*:*:postgres:${PG_PASSWORD}" > ${HOME}/.pgpass
    echo "127.0.0.1:*:*:schedule:${PG_SCHEDULE_PASSWORD}" >> ${HOME}/.pgpass
    chmod 600 ~/.pgpass

    # PostgreSQL and create DB
    #sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${PG_PASSWORD}';"
    #sudo -u postgres psql -c "create user schedule with encrypted password '${PG_SCHEDULE_PASSWORD}';"
    #sudo -u postgres psql -c "ALTER USER schedule SUPERUSER;"
    #createdb -h 127.0.0.1 -p 5432 -U schedule schedule
    #sudo -u postgres psql -c "grant all privileges on database schedule to schedule;"
    #sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE schedule TO postgres;"
    #sudo -u postgres psql -c "create database schedule_test;"
    #sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE schedule_test TO postgres;"


    sudo -u postgres psql << EOF
        ALTER USER postgres PASSWORD '${PG_PASSWORD}';
        CREATE USER schedule WITH ENCRYPTED PASSWORD '${PG_SCHEDULE_PASSWORD}';
        ALTER USER schedule SUPERUSER;
        CREATE DATABASE schedule OWNER = schedule;
        CREATE DATABASE schedule_test OWNER = postgres;
EOF
   
    psql -U schedule -h 127.0.0.1 -d schedule -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
    psql --set ON_ERROR_STOP=off -U schedule -h 127.0.0.1 -d schedule -1 -f ${HOME}/${DIR_PROJECT}/backup/2023-09-07_2.dump
else
    echo "==================================================================================="
    echo "Backup file not found"
    echo "==================================================================================="
fi

# OpenJDK 11
if ! command -v java &> /dev/null
then
    echo "==================================================================================="
    echo "OpenJDK 11 is not installed. Installing..."
    echo "==================================================================================="
    sudo apt install -y openjdk-11-jdk
else
    echo "==================================================================================="
    echo "OpenJDK 11 is already installed"
    echo "==================================================================================="
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
    echo "==================================================================================="
    echo "JAVA_HOME is already set"
    echo "==================================================================================="
fi

# Tomcat 9
if ! systemctl is-active --quiet tomcat9
then
    echo "==================================================================================="
    echo "Tomcat 9 is not running. Starting..."
    echo "==================================================================================="
    sudo apt install -y tomcat9
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9
    echo "Tomcat 9 is now running"
else
    echo "==================================================================================="
    echo "Tomcat 9 is already running"
    echo "==================================================================================="
fi

# Redis
if ! command -v redis-server &> /dev/null
then
    echo "==================================================================================="
    echo "Redis is not installed. Installing..."
    echo "==================================================================================="
    sudo apt install -y redis-server
    echo "Redis is now installed and running"
else
    echo "==================================================================================="
    echo "Redis is already installed and running"
    echo "==================================================================================="
fi

# MongoDB
if ! command -v mongod &> /dev/null
then
    echo "==================================================================================="
    echo "MongoDB is not installed. Installing..."
    echo "==================================================================================="
    curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" |  sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt -y update
    sudo apt install -y mongodb-org
    sudo systemctl start mongod.service
    echo "MongoDB is now installed and running"
else
    echo "==================================================================================="
    echo "MongoDB is already installed and running"
    echo "==================================================================================="
fi

# Build Java app
if [ -d ${HOME}/${DIR_PROJECT} ]
then
    cd ${HOME}/${DIR_PROJECT}
    chmod +x gradlew
    echo "==================================================================================="
    echo "Build app with GradleW and Deploy to TomCat"
    echo "==================================================================================="
    ./gradlew build
    # Devloy app to tomcat
    sudo rm -rf /var/lib/tomcat9/webapps/ROOT
    sudo mv ${HOME}/${DIR_PROJECT}/build/libs/class_schedule.war /var/lib/tomcat9/webapps/ROOT.war
    echo "==================================================================================="
    echo "==========Java application has been built and deployed============================="
    echo "==================================================================================="
else
    echo "==================================================================================="
    echo "Java application directory not found"
    echo "==================================================================================="
fi

if curl -s -o /dev/null -I -w "%{http_code}" http://localhost:8080/public/semesters | grep -q 200; then
    echo "==================================================================================="  
    echo "The application is accessible at http://localhost:8080/"
    echo "==================================================================================="
else
    echo "==================================================================================="
    echo "The application might not be accessible. Check your deployment."
    echo "==================================================================================="
fi
