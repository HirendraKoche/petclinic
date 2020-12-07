podTemplate(cloud: 'kubernetes', containers: [containerTemplate(command: 'tail', args: ["-f", "/dev/null"], image: 'maven:3-alpine', name: 'maven', ttyEnabled: true, workingDir: '/home/jenkins/agent')], label: 'build-agent'){
    node('build-agent'){
        stage 'CheckOut Code'
        checkout scm

        stage 'Build Code'
        container('maven'){
            sh 'mvn clean package'
        }
        
        
    }
}