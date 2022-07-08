#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=spring-pet-clinic

echo "> Build 파일 복사"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> 현재 구동중인 애플리케이션 pid 확인"

#CURRENT_PID=$(pgrep -fl spring-pet-clinic | grep jar | awk '{print $1}')
CURRENT_PID=$(pgrep -fl springpet-clinic  | awk '{print $1}')

echo "현재 구동중인 어플리케이션 pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
    echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
    echo "> kill -15 $CURRENT_PID"
    kill -15 $CURRENT_PID
    sleep 5
fi

echo "> 새 어플리케이션 배포"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"


#nohup java -jar $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
#nohup java -jar $REPOSITORY/spring-petclinic-2.6.0.jar 
nohup java -jar $REPOSITORY/spring-petclinic-2.6.0.jar  > $REPOSITORY/nohup.out 2>&1 &


#[stderr]ERROR in ch.qos.logback.core.rolling.RollingFileAppender[rollingFile] - Failed to create parent directories for [/./logs/application.log]
#Identify and stop the process that's listening on port 8080 or configure this application to listen on another port.
