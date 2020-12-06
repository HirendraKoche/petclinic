stage 'CI'
node {
    
    notify("STARTED")
    // Download code from repo
    stage 'CHECKOUT'
    checkout scm
    //git credentialsId: 'github-user', url: 'https://github.com/HirendraKoche/Maven-petclinic-project.git'
    
    // Build code using docker image maven:3-apline
    stage 'BUILD'
    powershell 'docker run --rm -v $env:M2_REPO:/root/.m2 -v $env:WORKSPACE:/code -w /code maven:3-alpine mvn clean package'
    
    stage 'Archieve Artifacts'
    stash includes: 'target/*.war, Dockerfile', name: 'petclinic-build-stash'
    stash includes: 'kube-petclinic.yaml', name: 'kube-petclinic'
    archiveArtifacts allowEmptyArchive: true, artifacts: 'target/*.war', followSymlinks: false, onlyIfSuccessful: true
    
    stage 'Publish Test Results'
    junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
    jacoco classPattern: 'target/classes', execPattern: 'target/jacoco.exec'
    notify("COMPLETED")
    
}

stage 'Create Docker Image'
node('agent1'){
    // clean workspace
    bat 'DEL /F/Q/S *.* > NUL'
     
    // Unstash artifacts.
    unstash 'petclinic-build-stash'
    
    // Build docker image from unstashed artifacts
    powershell 'docker build -t petclinic:$env:BUILD_NUMBER .'
    notify('Waiting to Deploy....')
}

stage 'Deploy'
input 'Build is ready to deploy. Do you wanted to proceed?'
node('agent1') {

    // clean workspace
    bat 'DEL /F/Q/S *.* > NUL'
    
    // Unstash artifacts.
    unstash 'kube-petclinic'
    
    // Deploy
    powershell 'get-content kube-petclinic.yaml | %{$_ -replace "BUILD", $env:BUILD_NUMBER} > temp-kube-petclinic.yaml'
    powershell 'get-content temp-kube-petclinic.yaml > kube-petclinic.yaml'
    powershell 'kubectl apply -f kube-petclinic.yaml'
    notify('Application deployed successfully')
}

def notify(STATUS) {
    emailext body: """<p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""", subject: """$JOB_NAME - #$BUILD_NUMBER : $STATUS""", to: 'hirendrakoche1@outlook.com'
}