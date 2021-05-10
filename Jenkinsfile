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
   }
   stages {
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
            withFolderProperties { withSonarQubeEnv('GalasaSonarQube') { withCredentials([string(credentialsId: 'galasa-gpg', variable: 'GPG')]) {
               dir('runtime') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -DdockerVersion=${env.DOCKER_VERSION} -Dgpg.skip=${GPG_SKIP} -Dgpg.passphrase=$GPG  -P ${MAVEN_PROFILE} -B -e ${MAVEN_GOAL}"
               }
            } } }
         }
      }
      
// Build the various global sites and features
      stage('global') {
         steps {
            withFolderProperties { withSonarQubeEnv('GalasaSonarQube') { withCredentials([string(credentialsId: 'galasa-gpg', variable: 'GPG')]) {
// Build the Eclipse p2 site
               dir('eclipse/dev.galasa.eclipse.site') {
                  sh "mvn -Dmaven.artifact.threads=1  --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -Dgpg.skip=${GPG_SKIP} -Dgpg.passphrase=$GPG -P ${MAVEN_PROFILE} -B -e ${MAVEN_GOAL}"
               }
            } } }
         }
      }
      
      stage('isolated-partial-zips') {
         steps {
            withFolderProperties { 
               dir('isolated/full/mavenrepo') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e ${MAVEN_GOAL}"
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
            withFolderProperties { 
            dir('docker') {            
// Build the emedded obr directory
               dir('dockerObr') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean process-sources galasa:obrembedded"
                  
                  sh "docker build -t ${env.DOCKER_REPO}/galasa-obr-generic:${env.DOCKER_VERSION} ." 
                  sh "docker push ${env.DOCKER_REPO}/galasa-obr-generic:${env.DOCKER_VERSION}" 
               }

// Build the sample test catalogs
               dir('testcatalogs') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean generate-sources"
                  
                  sh "docker build -t ${env.DOCKER_REPO}/galasa-testcatalogs-generic:${env.DOCKER_VERSION} ." 
                  sh "docker push ${env.DOCKER_REPO}/galasa-testcatalogs-generic:${env.DOCKER_VERSION}" 
               }

// Build the WebUI generic image
               dir('webuigeneric') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean process-sources"
                  
                  sh "docker build -t ${env.DOCKER_REPO}/galasa-webui-generic:${env.DOCKER_VERSION} ." 
                  sh "docker push ${env.DOCKER_REPO}/galasa-webui-generic:${env.DOCKER_VERSION}" 
               }


// Build the git hashes transient docker image
               dir('hashes') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean generate-sources"
                  
                  sh "echo -n ${GIT_COMMIT} > target/build.hash"
                  sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-githashes:${env.DOCKER_VERSION} ." 
                  sh "docker push ${env.DOCKER_REPO}/galasa-githashes:${env.DOCKER_VERSION}" 
               }
            }
            // Build the Isolated generic docker image
            dir('isolated/full/dockerGeneric') {
               sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean process-sources"
                  
               sh "docker build -t ${env.DOCKER_REPO}/galasa-isolated-full-generic:${env.DOCKER_VERSION} ." 
               sh "docker push ${env.DOCKER_REPO}/galasa-isolated-full-generic:${env.DOCKER_VERSION}" 
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
                  withFolderProperties { 
                  dir('repository/dev/galasa') {
                     deleteDir()
                  }

                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
                  }
            
                  dir('docker') {
                     dir('bootEmbedded') {
                        sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-boot-embedded-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-boot-embedded-amd64:${env.DOCKER_VERSION}" 
                     }

                     dir('resources') {
                        sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} --build-arg gitHash=${GIT_COMMIT} -t ${env.DOCKER_REPO}/galasa-resources-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-resources-amd64:${env.DOCKER_VERSION}" 
                     }
                     
                     dir('eclipse') {
                        sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean generate-sources"
                  
                        sh "docker build --build-arg gitHash=${GIT_COMMIT} --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-p2-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-p2-amd64:${env.DOCKER_VERSION}" 
                     }
               
                     dir('dockerOperator') {
                        sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean process-sources"
                  
                        sh "docker build --build-arg gitHash=${GIT_COMMIT} --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-docker-operator-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-docker-operator-amd64:${env.DOCKER_VERSION}" 
                     }
                     
                     dir('ibm/bootEmbedded') {
                        sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} --build-arg platform=amd64 -t ${env.DOCKER_REPO}/galasa-ibm-boot-embedded-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-ibm-boot-embedded-amd64:${env.DOCKER_VERSION}" 
                     }

// Build the javadocs image
                     dir('javadoc') {
                        sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean generate-sources"
                  
                        sh "docker build --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-javadoc-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-javadoc-amd64:${env.DOCKER_VERSION}" 
                     }

                     dir('webui') {
                        sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-webui-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-webui-amd64:${env.DOCKER_VERSION}" 
                     }

                  }
            // Build the Isolated generic docker image
                  dir('isolated/full/dockerPlatform') {
                        sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} --build-arg gitHash=${GIT_COMMIT} -t ${env.DOCKER_REPO}/galasa-isolated-full-amd64:${env.DOCKER_VERSION} ." 
                        sh "docker push ${env.DOCKER_REPO}/galasa-isolated-full-amd64:${env.DOCKER_VERSION}" 
                  }            
                  }
               }
            }
//            stage('s390x-docker-images') {
//               agent { 
//                  label 'docker-s390x'
//               }
//             options {
//                  skipDefaultCheckout false
//               }
//               environment {
//                  def workspace = pwd()
//               }
//               steps {
//                  withFolderProperties { 
//            
//                  dir('repository/dev/galasa') {
//                     deleteDir()
//                  }
//
//                  configFileProvider([configFile(fileId: '86dde059-684b-4300-b595-64e83c2dd217', targetLocation: 'settings.xml')]) {
//                  }
//            
//                dir('docker') {
//                   dir('bootEmbedded') {
//                      sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} -t ${env.DOCKER_REPO}/galasa-boot-embedded-s390x:${env.DOCKER_VERSION} -f Dockerfile.s390x ." 
//                      sh "docker push ${env.DOCKER_REPO}/galasa-boot-embedded-s390x:${env.DOCKER_VERSION}" 
//                       }
//                       
//                   dir('resources') {
//                      sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} --build-arg gitHash=${GIT_COMMIT} -t ${env.DOCKER_REPO}/galasa-resources-s390x:${env.DOCKER_VERSION} ." 
//                      sh "docker push ${env.DOCKER_REPO}/galasa-resources-s390x:${env.DOCKER_VERSION}" 
//                       }
//                       
//                   dir('ibm/bootEmbedded') {
//                      sh "docker build --pull --build-arg dockerVersion=${env.DOCKER_VERSION} --build-arg dockerRepository=${env.DOCKER_REPO} --build-arg platform=s390x -t ${env.DOCKER_REPO}/galasa-ibm-boot-embedded-s390x:${env.DOCKER_VERSION} ." 
//                      sh "docker push ${env.DOCKER_REPO}/galasa-ibm-boot-embedded-s390x:${env.DOCKER_VERSION}" 
//                       }
//               }
//                }            
//               }
//            }
//         }
//      }

      stage('isolated-completed-zips') {
         steps {
            withFolderProperties { 
               dir('isolated/full/zip') {
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e clean"
                  sh "mkdir -p target/zip"
                  sh "docker save ${env.DOCKER_REPO}/galasa-isolated-full-amd64:${env.DOCKER_VERSION} > target/zip/isolated.tar"
                  sh "mvn --settings ${workspace}/settings.xml -Dmaven.repo.local=${workspace}/repository -P ${MAVEN_PROFILE} -B -e deploy"
               }
            } 
         }
      }
   }
   post {
       // triggered when red sign
       failure {
           slackSend (channel: '#galasa-devs', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
       }
    }
}
