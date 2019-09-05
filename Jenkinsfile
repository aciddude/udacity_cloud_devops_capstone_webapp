pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building..{env.BUILD_NUMBER}'
        sh 'docker build -t acidd/udacity-weather-app:latest  -t acidd/udacity-weather-app:"${env.BUILD_NUMBER}" .'
        sh 'docker image ls'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing..'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying....'
      }
    }
  }
  environment {
    BUILDNO = '${env.BUILD_NUMBER}'
  }
}