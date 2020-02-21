def mvnProfile        = 'dev'
def dockerVersion     = '0.5.0'
def galasaSignJarSkip = 'true'

pipeline {
// Initially run on any agent
   agent {
      label 'codesigning'
   }
   environment {
//Configure Maven from the maven tooling in Jenkins
      def mvnHome = tool 'Default'
      PATH = "${mvnHome}/bin:${env.PATH}"
      
//Set some defaults
      def workspace = pwd()
      def mvnGoal    = 'install'
//      def dockerRepository = 'docker.galasa.dev'
      def dockerRepository = '9.20.205.160:5000'
   }
   stages {
// If it is the master branch, version 0.3.0 and master on all the other branches
      stage('set-dev') {
         when {
           environment name: 'GIT_BRANCH', value: 'origin/master'
         }
         steps {
            script {
               mvnGoal           = 'deploy'
               mvnProfile        = 'dev'
               dockerVersion     = '0.5.0-SNAPSHOT'
            }
         }
      }
// If it is the staging branch
      stage('set-staging') {
         when {
           environment name: 'GIT_BRANCH', value: 'origin/staging'
         }
         steps {
            script {
               mvnGoal           = 'deploy'
               mvnProfile        = 'staging'
               galasaSignJarSkip = 'false'
               dockerVersion     = '0.5.0'
            }
         }
      }

// for debugging purposes
      stage('report') {
         steps {
            echo "Branch/Tag         : ${env.GIT_BRANCH}"
            echo "GIT Commit Hash    : ${env.GIT_COMMIT}"
            echo "Workspace directory: ${workspace}"
            echo "Maven Goal         : ${mvnGoal}"
            echo "Maven profile      : ${mvnProfile}"
            echo "Docker Version     : ${dockerVersion}"
            echo "Docker Repository  : ${dockerRepository}"
            echo "Skip Signing JARs  : ${galasaSignJarSkip}"
         }
      }
   
// Set up the workspace, clear the git directories and setup the manve settings.xml files
      stage('prep-workspace') { 
         steps {
            configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
            }
            configFileProvider([configFile(fileId: '647688a9-d178-475b-ae65-80fca764a8c2', targetLocation: 'cit-settings.xml')]) {
            }
         
            dir('repository/dev.galasa') {
               deleteDir()
            }
            dir('repository/dev/galasa') {
               deleteDir()
            }
         }
      }
      
// Build the runtime repository
      stage('runtime') {
         steps {
            withCredentials([string(credentialsId: 'galasa-gpg', variable: 'GPG')]) {
               dir('runtime') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -DdockerVersion=${dockerVersion} -Dgpg.skip=false -Dgpg.passphrase=$GPG  -P ${mvnProfile} -B -e ${mvnGoal}"
               }
            }
         }
      }
      
// Build the various global sites and features
      stage('global') {
         steps {
            withCredentials([string(credentialsId: 'galasa-gpg', variable: 'GPG')]) {
// Build the Eclipse p2 site
               dir('eclipse/dev.galasa.eclipse.site') {
                  sh "mvn -Dmaven.artifact.threads=1  --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -Dgpg.skip=false -Dgpg.passphrase=$GPG -P ${mvnProfile} -B -e ${mvnGoal}"
               }
            }
         }
      }
      
// Spawn to a docker amd64 agent to build the generic (non-executable) images      
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

// Ensure we force the download of the galasa artifacts            
            dir('repository/dev/galasa') {
               deleteDir()
            }
        
            configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
            }
            
			dir('docker') {			   
// Build the emedded obr directory
			   dir('dockerObr') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean process-sources galasa:obrembedded"
			      
			      sh "docker build -t ${dockerRepository}/galasa-obr-generic:${dockerVersion} ." 
			      sh "docker push ${dockerRepository}/galasa-obr-generic:${dockerVersion}" 
			   }

// Build the sample test catalogs
			   dir('testcatalogs') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean generate-sources"
			      
			      sh "docker build -t ${dockerRepository}/galasa-testcatalogs-generic:${dockerVersion} ." 
			      sh "docker push ${dockerRepository}/galasa-testcatalogs-generic:${dockerVersion}" 
			   }
			}            
         }
      }
      
// Build all the platform specific docker images
//      stage('platform-docker-images') {
//         parallel { 
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
            
                  dir('repository/dev/galasa') {
                     deleteDir()
                  }

                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
                  }
            
			      dir('docker') {
			         dir('bootEmbedded') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-boot-embedded-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-boot-embedded-amd64:${dockerVersion}" 
   			         }

			         dir('resources') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} --build-arg gitHash=${GIT_COMMIT} -t ${dockerRepository}/galasa-resources-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-resources-amd64:${dockerVersion}" 
   			         }
   			         
                     dir('eclipse') {
                        sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean generate-sources"
                  
                        sh "docker build --build-arg gitHash=${GIT_COMMIT} -t ${dockerRepository}/galasa-p2-amd64:${dockerVersion} ." 
                        sh "docker push ${dockerRepository}/galasa-p2-amd64:${dockerVersion}" 
                     }
               
			         dir('ibm/bootEmbedded') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} --build-arg platform=amd64 -t ${dockerRepository}/galasa-ibm-boot-embedded-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-ibm-boot-embedded-amd64:${dockerVersion}" 
   			         }

// Build the javadocs image
			         dir('javadoc') {
			            sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean generate-sources"
			      
			            sh "docker build -t ${dockerRepository}/galasa-javadoc-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-javadoc-amd64:${dockerVersion}" 
			         }
			      }
               }
            }
//            stage('s390x-docker-images') {
//               agent { 
//                  label 'docker-s390x'
//               }
//	           options {
//                  skipDefaultCheckout false
//               }
//               environment {
//                  def workspace = pwd()
//               }
//               steps {
//            
//                  dir('repository/dev/galasa') {
//                     deleteDir()
//                  }
//
//                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
//                  }
//            
//			      dir('docker') {
//			         dir('bootEmbedded') {
//			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-boot-embedded-s390x:${dockerVersion} -f Dockerfile.s390x ." 
//			            sh "docker push ${dockerRepository}/galasa-boot-embedded-s390x:${dockerVersion}" 
//   			         }
//   			         
//			         dir('resources') {
//			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} --build-arg gitHash=${GIT_COMMIT} -t ${dockerRepository}/galasa-resources-s390x:${dockerVersion} ." 
//			            sh "docker push ${dockerRepository}/galasa-resources-s390x:${dockerVersion}" 
//   			         }
//   			         
//			         dir('ibm/bootEmbedded') {
//			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} --build-arg platform=s390x -t ${dockerRepository}/galasa-ibm-boot-embedded-s390x:${dockerVersion} ." 
//			            sh "docker push ${dockerRepository}/galasa-ibm-boot-embedded-s390x:${dockerVersion}" 
//   			         }
//			      }            
//               }
//            }
//         }
//      }
   }
   post {
       // triggered when red sign
       failure {
           slackSend (channel: '#galasa-devs', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
       }
    }
}
