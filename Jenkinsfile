pipeline {
  agent { label 'principal' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  stages {
    stage('Scan') {
      steps {
        withSonarQubeEnv(installationName: 'sq1') { 
          sh './gradlew sonarqube'
        }
      }
    }
  }
}