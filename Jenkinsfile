pipeline {
   agent any
   environment {
      def mvnHome = tool 'Default'
      env.PATH = "${mvnHome}/bin:${env.PATH}"
      
      def workspace = pwd()
   }
   stages {
      stage('prep-workspace') { 
         echo "Workspace directory: ${workspace}"
      
         withCredentials([usernamePassword(credentialsId: '633cd4b1-ea8c-4ce1-a6bc-f103009af770', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]){
            sh "docker login -u=${DOCKER_USER} -p=${DOCKER_PASSWORD} cicsts-docker-local.artifactory.swg-devops.com"
         }
   
         configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
         }
         configFileProvider([configFile(fileId: '647688a9-d178-475b-ae65-80fca764a8c2', targetLocation: 'cit-settings.xml')]) {
         }
         
         def exists = fileExists 'repository/dev/voras'
         if (exists) {
            dir('repository/dev/voras') {
               deleteDir()
            }
         }
         
         exists = fileExists 'git'
         if (exists) {
            dir('git') {
               deleteDir()
            }
         }
         
         exists = fileExists 'deploy'
         if (exists) {
            dir('deploy') {
               deleteDir()
            }
         }
      }
   }
}