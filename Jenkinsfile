podTemplate(cloud: 'kubernetes', containers: [containerTemplate(args: 'cat', command: '/bin/sh -c', image: 'maven:3-alpine', livenessProbe: containerLivenessProbe(execArgs: '', failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0, successThreshold: 0, timeoutSeconds: 0), name: 'maven', resourceLimitCpu: '', resourceLimitMemory: '', resourceRequestCpu: '', resourceRequestMemory: '', ttyEnabled: true, workingDir: '/home/jenkins/agent')], label: 'build-agent', namespace: 'jenkins'){
    node('build-agent'){
        stage 'CheckOut Code'
        checkout scm

        stage 'Build Code'
        container('maven'){
            sh 'mvn clean package'
        }
        
        
    }
}