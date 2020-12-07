podTemplate(cloud: 'kubernetes', yaml: """
apiVersion: v1
kind: Pod
metadata:
  name: build-agent
  namespace: jenkins
  labels:
    name: build-agent
spec:
  containers:
  - name: maven
    image: maven:3-alpine
    command:
      - cat
    tty: true
"""
){
    node('build-agent'){
        stage 'CheckOut Code'
        checkout scm

        stage 'Build Code'
        container('maven'){
            sh 'mvn clean package'
        }
        
        
    }
}