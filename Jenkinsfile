podTemplate(
    label: 'build-agent',
    podRetention: always(),
    containers: [
        containerTemplate(
            command: 'cat', 
            image: 'maven:3.3.9-jdk-8-alpine', 
            name: 'maven', 
            ttyEnabled: true
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