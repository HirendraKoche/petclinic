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
            workingDir: '/home/jenkins/agent'
        ), 
        containerTemplate(
            image: 'jenkins/slave:3.23-1-alpine', 
            name: 'jnlp', 
            resourceLimitCpu: '', 
            resourceLimitMemory: '', 
            resourceRequestCpu: '', 
            resourceRequestMemory: '', 
            ttyEnabled: true, 
            workingDir: '/home/jenkins/agent'
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
            git credentialsId: 'git-user', url: 'https://github.com/HirendraKoche/Maven-petclinic-project.git'

            stage 'Build code'
            sh 'mvn clean package'
        }
    }
}