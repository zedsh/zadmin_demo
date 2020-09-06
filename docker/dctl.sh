#!/bin/bash
set -e
#first cd current dir
cd "$(dirname "${BASH_SOURCE[0]}")"

export DEFAULT_USER="1000";
export DEFAULT_GROUP="1000";

export USER_ID=`id -u`
export GROUP_ID=`id -g`
export USER=$USER


if [ "$USER_ID" == "0" ];
then
    export USER_ID=$DEFAULT_USER;
fi

if [ "$GROUP_ID" == "0" ];
then
    export GROUP_ID=$DEFAULT_GROUP;
fi


test -e "./.env" || { cp .env.example .env; };
#load .env
export $(egrep -v '^#' .env | xargs)

if [ $# -eq 0 ]
  then
    echo "HELP:"
    echo "make env - copy .env.example to .env"
    echo "make db - load init bitrix database dump to mysql"
    echo "db import FILE - load FILE to mysql"
    echo "db renew - load dump from repo, fresh db and apply"
    echo "build - make docker build"
    echo "up - docker up in console"
    echo "up silent - docker up daemon"
    echo "down - docker down"
    echo "run - run in php container from project root"
    echo "test - run tests"
    echo "cept some_command (cept generate:cept acceptance Test) - run codeception with params"
fi

function applyDump {
    cat $1 | docker exec -i ${PROJECT_PREFIX}_mysql mysql -u $MYSQL_USER -p"$MYSQL_PASSWORD" $MYSQL_DATABASE;
    return $?
}

function runInMySql {
    local command=$@
    docker exec -i ${PROJECT_PREFIX}_mysql su mysql -c "$command"
    return $?
}

function runInPhp {
    local command=$@
    echo $command;
    docker exec -i ${PROJECT_PREFIX}_php su www-data -c "cd /var/www/html/;$command"
    return $?
}

function runInRabbitMq {
    local command=$@
    echo $command;
    docker exec -i ${PROJECT_PREFIX}_rabbitmq bash -c "$command"
    return $?
}


if [ "$1" == "make" ];
  then
    if [ "$2" == "env" ];
        then
            cp .env.example .env
    fi
    if [ "$2" == "db" ];
        then
         applyDump "../bitrix/database/init.sql";
    fi
fi

if [ "$1" == "db" ];
  then

    if [ "$2" == "" ];
        then
        docker exec -it ${PROJECT_PREFIX}_mysql mysql -u $MYSQL_USER -p"$MYSQL_PASSWORD" $MYSQL_DATABASE;
    fi

    if [ "$2" == "import" ];
        then
        applyDump $3
    fi

    if [ "$2" == "export" ];
        then
        runInMySql "mysqldump -u $MYSQL_USER -p"$MYSQL_PASSWORD" $MYSQL_DATABASE";
    fi

    if [ "$2" == "renew" ];
        then
        rm -rf "../docker/data/mysql/dump" || echo "old dump not found"
        git clone $DATABASE_REPO ../docker/data/mysql/dump
        applyDump "../docker/containers/mysql/drop_all_tables.sql"
        applyDump "../docker/data/mysql/dump/database.sql"
    fi

fi

if [ "$1" == "build" ];
  then
    docker-compose build
fi

if [ "$1" == "up" ];
  then
    if [ "$2" == "silent" ];
        then
            docker-compose -p ${PROJECT_PREFIX} up -d;
        else
            docker-compose -p ${PROJECT_PREFIX} up
    fi
fi

if [ "$1" == "down" ];
  then
    docker-compose -p ${PROJECT_PREFIX} down
fi

if [ "$1" == "fulldown" ];
  then
    docker-compose -p ${PROJECT_PREFIX} down --rmi local
fi



if [ "$1" == "test" ];
  then
        runInPhp php vendor/bin/codecept run --env docker --debug
fi

if [ "$1" == "cept" ];
  then
    runInPhp php vendor/bin/codecept "${@:2}"
fi


if [ "$1" == "run" ];
  then
    if [ "$2" == "" ];
        then
        docker exec -u www-data -it ${PROJECT_PREFIX}_php bash
        else
        runInPhp "${@:2}"
    fi
fi

if [ "$1" == "rabbitmq" ];
  then

    if [ "$2" == "up" ];
        then
            runInRabbitMq "rabbitmqctl delete_user guest"
            runInRabbitMq "rabbitmqctl add_vhost /"
            runInRabbitMq "rabbitmqctl add_user $RABBITMQ_LOGIN $RABBITMQ_PASSWORD"
            runInRabbitMq "rabbitmqctl set_user_tags $RABBITMQ_LOGIN administrator"
            runInRabbitMq "rabbitmqctl set_permissions -p / $RABBITMQ_LOGIN '.*' '.*' '.*'"
    fi

fi

