pipeline {
  agent any
  stages {
    stage('Lint Dockerfile') {
      agent {
        docker {
          image 'hadolint/hadolint:latest-debian'
        }

      }
      post {
        always {
          archiveArtifacts 'hadolint_lint.txt'

        }

      }
      steps {
        sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
        sh '''
        lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
        if [ "$lintErrors" -gt "0" ]; then
           echo "Linting Errors, please see below"
           cat hadolint_lint.txt
           exit 1
        else
        echo "Dockerfile is valid!!"
        fi
        '''
      }
    }
    stage('Build & Tag Docker Image') {
      steps {
        sh "echo Building.. ${env.BUILDNO}"
        sh "docker build -t acidd/udacity-weather-app:latest  -t acidd/udacity-weather-app:${env.BUILD_NUMBER} ."
      }
    }
    stage('Building image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }

      }
    }
    stage('Test Docker Image') {
      steps {
        echo 'Testing docker image'
        sh "docker run -p 8081:8080 -d acidd/udacity-weather-app:${env.BUILD_NUMBER}  "
        echo 'Waiting for Docker container to start....'
        sleep 5
        sh '''
        isGetWeatherTrue=$(curl localhost:8081 -s  | grep "Get Weather" -c)
        isTrue="1"
        if [ "$isGetWeatherTrue" == "$isTrue" ]; then
        echo "Was able to grep for string "Get Weather" - curl passed with code 200 "
        else
        echo "Unable to find string "Get Weather " - curl failed, stopping docker container and exiting"
        sh \'docker stop $(docker ps --format "{{.ID}}" )\'
        exit 1
        fi
        '''
        echo 'Stopping Docker Container'
        sh 'docker stop $(docker ps --format "{{.ID}}" )'
      }
    }
    stage('Push Image to DockerHub') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }

      }
    }
    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage('Deploy') {
      steps {
        withAWS(credentials: 'aws-credentials', region: 'eu-west-2') {
          sh 'aws iam get-user'
          echo 'Deploying....'
          withKubeConfig(credentialsId: 'eks-config', serverUrl: 'https://55E0FA2E328E33F801D6AC2A4D55E58A.yl4.eu-west-2.eks.amazonaws.com') {
            sh '''
               export PATH="$PATH:/usr/local/bin/" 
               kubectl get nodes
          '''
          }

        }

      }
    }
    stage('Clean Up') {
      steps {
        echo 'Removing all docker images built'
        sh 'docker image rm "$(docker image ls  --format "{{.ID}}")" --force'
      }
    }
  }
  environment {
    BUILDNO = "${env.BUILD_NUMBER}"
    registry = 'acidd/udacity-weather-app'
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
}