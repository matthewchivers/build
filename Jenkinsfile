pipeline {
   agent any
   environment {
      def mvnHome = tool 'Default'
      PATH = "${mvnHome}/bin:${env.PATH}"
      
      def workspace = pwd()
      
      def mvnGoal    = 'deploy'
      def mvnProfile = 'voras-preprod'
      
      def dockerVersion = 'preprod'
      def dockerLatest  = 'true'
      def dockerRepository = 'cicsts-docker-local.artifactory.swg-devops.com'
   }
   options {
    skipDefaultCheckout true
   }
   stages {
      stage('report') {
         steps {
            echo "Workspace directory: ${workspace}"
            echo "Maven Goal         : ${mvnGoal}"
            echo "Maven profile      : ${mvnProfile}"
            echo "Docker Version     : ${dockerVersion}"
            echo "Docker Latest      : ${dockerLatest}"
            echo "Docker Repository  : ${dockerRepository}"
         }
      }
   
      stage('prep-workspace') { 
         steps {
            configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
            }
            configFileProvider([configFile(fileId: '647688a9-d178-475b-ae65-80fca764a8c2', targetLocation: 'cit-settings.xml')]) {
            }
         
            dir('repository/dev/voras') {
               deleteDir()
            }
            dir('git') {
               deleteDir()
            }
            dir('deploy') {
               deleteDir()
            }
         }
      }
      
      stage('wrapping') {
         steps {
            dir('git/wrapping') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/wrapping.git'
         
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
            }
         }
      }
      
      stage('maven') {
         steps {
            dir('git/maven') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/maven.git'
         
               dir('voras-maven-plugin') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
      stage('framework') {
         steps {
            dir('git/framework') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/framework.git'
         
               dir('voras-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
      stage('core') {
         steps {
            dir('git/core') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/core.git'
         
               dir('voras-core-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
      stage('common') {
         steps {
            dir('git/common') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/common.git'
         
               dir('voras-common-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
      stage('runtime') {
         steps {
            dir('git/runtime') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/runtime.git'
         
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
            }
         }
      }
      
      stage('devtools') {
         steps {
            dir('git/devtools') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/devtools.git'
         
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
            }
         }
      }
      
      stage('ivt') {
         steps {
            dir('git/ivt') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:eJATv3/ivt.git'
         
               dir('voras-ivt-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
      stage('generic-docker-images') {
         agent { 
            label 'docker-amd64'
         }
	     options {
            skipDefaultCheckout false
         }
         environment {
            def workspace = pwd()
         }
         steps {
            
            dir('repository/dev/voras') {
               deleteDir()
            }

            withCredentials([usernamePassword(credentialsId: '633cd4b1-ea8c-4ce1-a6bc-f103009af770', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]){
               sh "docker login -u=${DOCKER_USER} -p=${DOCKER_PASSWORD} ${dockerRepository}"
            }
   
            configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
            }
            
			dir('docker') {
			   dir('mavenRepository') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean voras:mavenrepository"
			      
			      sh "docker build -t ${dockerRepository}/voras-maven-repo-generic:$dockerVersion ." 
			      sh "docker push ${dockerRepository}/voras-maven-repo-generic:$dockerVersion" 
			   }
			   
			   dir('dockerObr') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean voras:obrembedded"
			      
			      sh "docker build -t ${dockerRepository}/voras-obr-generic:$dockerVersion ." 
			      sh "docker push ${dockerRepository}/voras-obr-generic:$dockerVersion" 
			   }
			}            
         }
      }
      
      stage('platform-docker-images') {
         parallel {
            stage('amd64-docker-images') {
               agent { 
                  label 'docker-amd64'
               }
	           options {
                  skipDefaultCheckout false
               }
               environment {
                  def workspace = pwd()
               }
               steps {
            
                  dir('repository/dev/voras') {
                     deleteDir()
                  }

                  withCredentials([usernamePassword(credentialsId: '633cd4b1-ea8c-4ce1-a6bc-f103009af770', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]){
                     sh "docker login -u=${DOCKER_USER} -p=${DOCKER_PASSWORD} ${dockerRepository}"
                  }
   
                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
                  }
            
			      dir('docker') {
			         dir('bootEmbedded') {
			            sh "docker build -t ${dockerRepository}/voras-boot-embedded-amd64:$dockerVersion ." 
			            sh "docker push ${dockerRepository}/voras-boot-embedded-amd64:$dockerVersion" 
   			         }
			      }            
               }
            }
            stage('s390x-docker-images') {
               agent { 
                  label 'docker-s390x'
               }
	           options {
                  skipDefaultCheckout false
               }
               environment {
                  def workspace = pwd()
               }
               steps {
            
                  dir('repository/dev/voras') {
                     deleteDir()
                  }

                  withCredentials([usernamePassword(credentialsId: '633cd4b1-ea8c-4ce1-a6bc-f103009af770', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]){
                     sh "docker login -u=${DOCKER_USER} -p=${DOCKER_PASSWORD} ${dockerRepository}"
                  }
   
                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
                  }
            
			      dir('docker') {
			         dir('bootEmbedded') {
			            sh "docker build -t ${dockerRepository}/voras-boot-embedded-s390x:$dockerVersion -f Dockerfile.s390x ." 
			            sh "docker push ${dockerRepository}/voras-boot-embedded-s390x:$dockerVersion" 
   			         }
			      }            
               }
            }
         }
      }
   }
}