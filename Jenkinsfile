pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh "echo Building.. ${env.BUILDNO}"
        sh "docker build -t acidd/udacity-weather-app:latest  -t acidd/udacity-weather-app:${env.BUILD_NUMBER} ."
        sh 'docker image ls'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing docker image'
        sh "docker run -p 8081:8080 -d acidd/udacity-weather-app:${env.BUILD_NUMBER}  "
        sh '''
isGetWeatherTrue=$(curl localhost:8081 -s  | grep "Get Weather" -c)
isTrue="1"
 
if [ "$isGetWeatherTrue" == "isTrue" ]; then
    echo "YAY It\'s working"
else
    echo "Booo It\'s not working"
    exit 1
fi  
        '''
        sh 'docker stop $(docker ps --format "{{.ID}}" )'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying....'
      }
    }
  }
  environment {
    BUILDNO = "${env.BUILD_NUMBER}"
  }
}