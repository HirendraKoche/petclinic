podTemplate(
    label: 'build-agent'
    podRetention: always(),
    containers: [
        containerTemplate(
            command: 'cat', 
            image: 'maven:3.3.9-jdk-8-alpine', 
            name: 'maven', 
            ttyEnabled: true
        ),
    ],
    volumes: [
        hostPathVolume(
            mountPath: '/var/run/docker.sock',
            hostPath: '/var/run/docker.sock'
        ),  
    ],
 )
 {
    node(POD_LABEL){
        stage 'CheckOut Code'
        git credentialsId: 'git-user', url: 'https://github.com/HirendraKoche/Maven-petclinic-project.git'
        container('maven'){ 
            sh 'mvn clean package'
        }
    }
}