podTemplate(cloud: 'kubernetes', containers: [containerTemplate(args: 'cat', command: '/bin/sh -c', image: 'maven:3-alpine', name: 'maven', resourceLimitCpu: '', resourceLimitMemory: '', resourceRequestCpu: '', resourceRequestMemory: '', ttyEnabled: true, workingDir: '/home/jenkins/agent')], label: 'build-agent', namespace: 'jenkins'){
    node('build-agent'){
        stage 'CheckOut Code'
        checkout scm

        stage 'Build Code'
        container('maven'){
            sh 'mvn clean package'
        }
        
        
    }
}