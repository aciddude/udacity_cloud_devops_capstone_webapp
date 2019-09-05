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
        sh "docker run acidd/udacity-weather-app:${env.BUILD_NUMBER} -p 8080:8080 "
        sh 'curl http://localhost:8080 -vvv'
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