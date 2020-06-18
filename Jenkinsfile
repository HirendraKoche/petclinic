pipeline{
	agent any
	
	stages{
		stage("Build Application"){
			steps{
				sh '''
					./jenkins/build/mvn_build.sh mvn -Dmaven.repo.local=$JENKINS_HOME/.m2 clean install
		   		   '''
			}
		}

		stage("Build Docker Image"){
			steps{
				sh '''
					./jenkins/docker/buildImage.sh
				   '''
			}
		}

		stage("Archieve Artifacts"){
			steps{
				archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
			}
		}
		
		stage("Push Image to Repository"){
			environment{
                		REPO_USER='hirendrakoche'
               			REPO_PASS=credentials('docker-hub-pass')
        		}
			steps{
				sh '''
					./jenkins/docker/pushImage.sh $REPO_USER $REPO_PASS
				   '''
			}
		}

		stage("Publish Test Results"){
			steps{
				sh 'sleep 2'	
				junit 'target/surefire-reports/*.xml'
			}
		}
	}
	
	post{
		always{
			emailext body: '''Please find below status of the job.\n$JOB_NAME #$BUILD_NUMBER : $BUILD_STATUS\nPlease review logs at $BUILD_URL''', subject: '$JOB_NAME #$BUILD_NUMBER : $BUILD_STATUS', to: 'hirendrakoche1@outlook.com'
		}
	
		success{
                        ansiColor('xterm') {
                           ansiblePlaybook colorized: true, disableHostKeyChecking: true, extraVars: [BUILD_TAG: "$BUILD_NUMBER"], inventory: 'jenkins/docker/deploy/hosts', playbook: 'jenkins/docker/deploy/deploy.yml'
                        }
			
		}

		failure{
			echo "Failure"
		}
	}
}
