def mvnProfile    = 'unknown'
def dockerVersion = 'unknown'
def gitBranch     = 'unknown'

pipeline {
// Initially run on any agent
   agent any
   environment {
//Configure Maven from the maven tooling in Jenkins
      def mvnHome = tool 'Default'
      PATH = "${mvnHome}/bin:${env.PATH}"
      
//Set some defaults
      def workspace = pwd()
      def mvnGoal    = 'deploy'
      def dockerRepository = 'cicsts-docker-local.artifactory.swg-devops.com'
   }
   stages {
// If it is the master branch, version 0.3.0 and master on all the other branches
      stage('set-dev') {
         when {
           environment name: 'GIT_BRANCH', value: 'origin/master'
         }
         steps {
            script {
               mvnProfile    = 'galasa-dev'
               dockerVersion = '0.3.0'
               gitBranch     = 'master'
            }
         }
      }
// If the test-preprod tag,  then set as appropriate
      stage('set-test-preprod') {
         when {
           environment name: 'GIT_BRANCH', value: 'origin/testpreprod'
         }
         steps {
            script {
               mvnProfile    = 'galasa-preprod'
               dockerVersion = 'preprod'
               gitBranch     = 'testpreprod'
            }
         }
      }

// for debugging purposes
      stage('report') {
         steps {
            echo "Branch/Tag         : ${env.GIT_BRANCH}"
            echo "Repo Branches      : ${gitBranch}"
            echo "Workspace directory: ${workspace}"
            echo "Maven Goal         : ${mvnGoal}"
            echo "Maven profile      : ${mvnProfile}"
            echo "Docker Version     : ${dockerVersion}"
            echo "Docker Repository  : ${dockerRepository}"
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
            dir('git/wrapping') {
               deleteDir()
            }
            dir('git/maven') {
               deleteDir()
            }
            dir('git/framework') {
               deleteDir()
            }
            dir('git/core') {
               deleteDir()
            }
            dir('git/common') {
               deleteDir()
            }
            dir('git/eclipse') {
               deleteDir()
            }
            dir('git/simframe') {
               deleteDir()
            }
            dir('git/runtime') {
               deleteDir()
            }
            dir('git/devtools') {
               deleteDir()
            }
            dir('git/ivt') {
               deleteDir()
            }
            dir('git/inttests') {
               deleteDir()
            }
         }
      }
      
// Build the wrapping repository
      stage('wrapping') {
         steps {
            dir('git/wrapping') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/wrapping.git', branch: "${gitBranch}"
         
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
            }
         }
      }
      
// Build the maven repository
      stage('maven') {
         steps {
            dir('git/maven') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/maven.git', branch: "${gitBranch}"
         
               dir('galasa-maven-plugin') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
// Build the framework repository
      stage('framework') {
         steps {
            dir('git/framework') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/framework.git', branch: "${gitBranch}"
         
               dir('galasa-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
// Build the core repository
      stage('core') {
         steps {
            dir('git/core') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/core.git', branch: "${gitBranch}"
         
               dir('galasa-core-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
// Build the common repository
      stage('common') {
         steps {
            dir('git/common') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/common.git', branch: "${gitBranch}"
         
               dir('galasa-common-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
// Build the simframe
      stage('simframe') {
         steps {
            dir('git/simframe') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/simframe.git', branch: "${gitBranch}"
         
               dir('simframe-application') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
// Build the eclipse
      stage('eclipse') {
         steps {
            dir('git/eclipse') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/eclipse.git', branch: "${gitBranch}"
         
               dir('galasa-eclipse-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
               }
            }
         }
      }
      
// Build the runtime repository
      stage('runtime') {
         steps {
            dir('git/runtime') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/runtime.git', branch: "${gitBranch}"
         
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -DdockerVersion=${dockerVersion} -P ${mvnProfile} -B -e -fae ${mvnGoal}"
            }
         }
      }
      
// Build the devtools repository
      stage('devtools') {
         steps {
            dir('git/devtools') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/devtools.git', branch: "${gitBranch}"
         
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
            }
         }
      }
      
// Build the Installation Verification Tests repository
      stage('ivt') {
         steps {
            dir('git/ivt') {
               git credentialsId: 'df028cc4-778d-4f90-ab52-e2a0db283c9f', url: 'git@github.ibm.com:galasa/ivt.git', branch: "${gitBranch}"
         
               dir('galasa-ivt-parent') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e -fae ${mvnGoal}"
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
            
			dir('git/build/docker') {
// Build the maven repository image
			   dir('mavenRepository') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -DdockerVersion=${dockerVersion} -P ${mvnProfile} -B -e clean galasa:mavenrepository"
			      
			      sh "docker build -t ${dockerRepository}/galasa-maven-repo-generic:${dockerVersion} ." 
			      sh "docker push ${dockerRepository}/galasa-maven-repo-generic:${dockerVersion}" 
			   }
			   
// Build the javadocs image
			   dir('javadoc') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean generate-sources"
			      
			      sh "docker build -t ${dockerRepository}/galasa-javadoc-generic:${dockerVersion} ." 
			      sh "docker push ${dockerRepository}/galasa-javadoc-generic:${dockerVersion}" 
			   }
			   
// Build the javadocs image
			   dir('eclipse') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean generate-sources"
			      
			      sh "docker build -t ${dockerRepository}/galasa-eclipse-generic:${dockerVersion} ." 
			      sh "docker push ${dockerRepository}/galasa-eclipse-generic:${dockerVersion}" 
			   }
			   
// Build the emedded obr directory
			   dir('dockerObr') {
			      sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean process-sources galasa:obrembedded"
			      
			      sh "docker build -t ${dockerRepository}/galasa-obr-generic:${dockerVersion} ." 
			      sh "docker push ${dockerRepository}/galasa-obr-generic:${dockerVersion}" 
			   }
			}            
         }
      }
      
// Build all the platform specific docker images
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
            
                  dir('repository/dev/galasa') {
                     deleteDir()
                  }

                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
                  }
            
			      dir('git/build/docker') {
			         dir('bootEmbedded') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-boot-embedded-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-boot-embedded-amd64:${dockerVersion}" 
   			         }

			         dir('rasCouchdbInit') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-ras-couchdb-init-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-ras-couchdb-init-amd64:${dockerVersion}" 
   			         }
   			         
			         dir('resources') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-resources-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-resources-amd64:${dockerVersion}" 
   			         }
   			         
			         dir('ibm/bootEmbedded') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} --build-arg platform=amd64 -t ${dockerRepository}/galasa-ibm-boot-embedded-amd64:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-ibm-boot-embedded-amd64:${dockerVersion}" 
   			         }
			      }
			                  
			      dir('git/build/karaf-distributions/bootstrap') {
			         sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${mvnProfile} -B -e clean install"
			      
			         sh "docker build -t ${dockerRepository}/galasa-api-bootstrap-amd64:${dockerVersion} ." 
			         sh "docker push ${dockerRepository}/galasa-api-bootstrap-amd64:${dockerVersion}" 
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
            
                  dir('repository/dev/galasa') {
                     deleteDir()
                  }

                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
                  }
            
			      dir('git/build/docker') {
			         dir('bootEmbedded') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-boot-embedded-s390x:${dockerVersion} -f Dockerfile.s390x ." 
			            sh "docker push ${dockerRepository}/galasa-boot-embedded-s390x:${dockerVersion}" 
   			         }
   			         
			         dir('rasCouchdbInit') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-ras-couchdb-init-s390x:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-ras-couchdb-init-s390x:${dockerVersion}" 
   			         }
   			         
			         dir('resources') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} -t ${dockerRepository}/galasa-resources-s390x:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-resources-s390x:${dockerVersion}" 
   			         }
   			         
			         dir('ibm/bootEmbedded') {
			            sh "docker build --pull --build-arg dockerVersion=${dockerVersion} --build-arg dockerRepository=${dockerRepository} --build-arg platform=s390x -t ${dockerRepository}/galasa-ibm-boot-embedded-s390x:${dockerVersion} ." 
			            sh "docker push ${dockerRepository}/galasa-ibm-boot-embedded-s390x:${dockerVersion}" 
   			         }
			      }            
               }
            }
         }
      }
   }
   post {
       // triggered when red sign
       failure {
           slackSend (channel: '#cics-galasa', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
       }
    }
}