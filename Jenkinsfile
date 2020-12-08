podTemplate(
    label: 'build-agent',
    containers: [
        containerTemplate(
            command: 'cat', 
            image: 'maven:3-alpine', 
            name: 'maven', 
            ttyEnabled: true
        ),
        containerTemplate(
            name: 'jnlp',
            image: 'jenkinsci/jnlp-slave:3.10-1-alpine',
            args: '${computer.jnlpmac} ${computer.name}'
        )
    ],
    volumes: [ 
        hostPathVolume(
            mountPath: '/var/run/docker.sock', 
            hostPath: '/var/run/docker.sock'
        ) 
    ] 
 )
 {
    node('build-agent'){
        stage 'CheckOut Code'
        git credentialsId: 'git-user', url: 'https://github.com/HirendraKoche/Maven-petclinic-project.git'

        stage 'Build Code'
        container('maven'){ 
            sh 'mvn clean package'
        }
    }
}