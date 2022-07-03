#!/bin/bash
HEALTH_CHECK_URL=http://127.0.0.1:8080/actuator/health
HEALTH_CHECK_PATTERN='"status":"UP"'

echo "> Health check 시작"
echo "> curl -s $HEALTH_CHECK_URL "

for RETRY_COUNT in {1..120}
do
  RESPONSE=$(curl -s $HEALTH_CHECK_URL)
  UP_COUNT=$(echo $RESPONSE | grep "${HEALTH_CHECK_PATTERN}" | wc -l)

  if [ $UP_COUNT -ge 1 ]
  then # $up_count >= 1 ("200" 문자열이 있는지 검증)
    echo "> Health check 성공"
    exit 0
  else
    echo "> Health check의 응답을 알 수 없거나 혹은 status가 UP이 아닙니다."
    echo "> Health check: ${RESPONSE}"
  fi

  echo "> Health check 연결 실패. 재시도..."
  sleep 5
done

echo "> Health check 실패. "
exit 1
