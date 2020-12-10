podTemplate(
    cloud: 'kubernetes', 
    label: 'build-agent', 
    name: 'build-agent', 
    namespace: 'jenkins', 
    showRawYaml: false, 
    containers: [
        containerTemplate(
            args: 'cat', 
            command: '/bin/sh -c', 
            image: 'maven:3-alpine', 
            name: 'maven', 
            resourceLimitCpu: '', 
            resourceLimitMemory: '', 
            resourceRequestCpu: '', 
            resourceRequestMemory: '', 
            ttyEnabled: true, 
            workingDir: '/home/jenkins'
        ), 
        containerTemplate(
            image: 'jenkins/inbound-agent', 
            name: 'jnlp',  
            envVars: [
                envVar(
                    key: 'JENKINS_URL',
                    value: 'http://jenkins-svc:8080'
                ),
                envVar(
                    key: 'JENKINS_TUNNEL',
                    value: 'jenkins-svc:50000'
                ),
            ],
            resourceLimitCpu: '', 
            resourceLimitMemory: '', 
            resourceRequestCpu: '', 
            resourceRequestMemory: '', 
            ttyEnabled: true, 
            workingDir: '/home/jenkins'
        )
    ], 
    volumes: [
        hostPathVolume(
            hostPath: '/var/run/docker.sock', 
            mountPath: '/var/run/docker.sock'
        )
    ]
){
    node('build-agent'){
        container('maven'){
            stage 'CheckOut Code'
            checkout scm

            stage 'Build code'
            sh 'mvn clean package'
        }
    }
}