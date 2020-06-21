pipeline{
	agent any
	
	stages{
		stage("Build Application"){
			steps{
				sh '''
					./jenkins/build/mvn_build mvn -Dmaven.repo.local=$JENKINS_HOME/.m2 clean install
		   		   '''
			}

			post{
				failure{
					script{				
						def newIssue = [
							fields: [
								project: [key: 'PET'],
								summary: "${JOB_NAME} #${BUILD_NUMBER} Failed.",
								description: 'Build failed. Please check attached logs.',
								issuetype: [ name: 'Task' ],
								priority: [ name: 'High'],
								components: [[ name: 'User Interface' ]]
							]
						]

						response = jiraNewIssue issue: newIssue, site: 'jira'
						
						def notify = [
							fields: [
								subject: "${JOB_NAME} #${BUILD_NUMBER} Failed.",
								textBody: "Build failed. Jira issue" + response.data.key + " has been created."
								to: [
									reporter: true,
									assignee: true
								]
							]
						]

						jiraNotifyIssue idOrKey: response.data.key, notify: notify, site: 'jira'

					}
					
				}
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
		
		success{
			emailext body: '''Build process completed. If you want proceed with deployment, acces below URL.\n${BUILD_URL}input''', subject: '$JOB_NAME #$BUILD_NUMBER : $BUILD_STATUS', to: 'hirendrakoche1@outlook.com'

			input id: 'Deploy', message: 'Build is successful. Do you want to proceed for deployment?', submitter: 'admin', submitterParameter: 'approver'

            ansiColor('xterm') {
            	ansiblePlaybook colorized: true, disableHostKeyChecking: true, extraVars: [BUILD_TAG: "$BUILD_NUMBER"], inventory: 'jenkins/docker/deploy/hosts', playbook: 'jenkins/docker/deploy/deploy.yml'
            }
		}

	}
}
