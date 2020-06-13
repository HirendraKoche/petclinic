pipeline{
	agent any

	environment{
		REPO_USER='hirendrakoche'
		REPO_PASS=credentials('')
	}
	
	stages{
		stage("Build Application"){
			steps{
				sh '''
					./jenkins/build/mvn_build.sh
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
				archiveArtifacts artifacts: 'tartget/*.war', onlyIfSuccessful: true
			}
		}
		
		stage("Push Image to Repository"){
			steps{
				sh '''
					./jenkins/docker/pushImage.sh
				   '''
			}
		}

		stage("Publish Test Results"){
			steps{
				junit 'target/surefire-reports/*.xml'
			}
		}
	}
	
	post{
		always{
			emailext body: '''Please find below status of the job.\n$JOB_NAME #$BUILD_NUMBER : $BUILD_STATUS\nPlease review logs at $BUILD_URL''', subject: '$JOB_NAME #$BUILD_NUMBER : $BUILD_STATUS', to: 'hirendrakoche1@outlook.com'
		}

		failure{
		}
	}
}
