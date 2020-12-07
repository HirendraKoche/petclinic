podTemplate(cloud: 'kubernetes', containers: [containerTemplate(args: '/dev/null', command: 'tailf', image: 'maven:3-alpine', name: 'maven', ttyEnabled: true, workingDir: '/home/jenkins/agent')], label: 'build-agent'){
    node('build-agent'){
        stage 'CheckOut Code'
        checkout scm

        stage 'Build Code'
        container('maven'){
            sh 'mvn clean package'
        }
        
        
    }
}