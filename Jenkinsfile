pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building..'
        sh 'docker build -t acidd/udacity-weather-app:latest  -t acidd/udacity-weather-app:${BUILDNO} .'
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
    BUILDNO = '${currentBuild.number}'
  }
}