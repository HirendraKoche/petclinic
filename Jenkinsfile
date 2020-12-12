podTemplate(
    cloud: 'kubernetes',
    yaml: """
        apiVersion: v1
        kind: Pod
        metadata:
            namespace: jenkins
        spec:
            volumes:
                - name: docker-sock
                hostPath:
                    path: /var/run/docker.sock
                - name: m2-repo
                PersistentVolumeClaim:
                    claimName: jenkins-pvc
            
            containers:
                - name: maven
                  image: maven:3-alpine
                  command:
                    - /bin/bash
                    - -c
                  args:
                    - cat
                  tty: true
                  workingDir: /home/jenkins/agent
                  volumeMounts:
                    - name: m2-repo
                      mountPath: /home/jenkins/agent
                      subPath: m2
                
                - name: jnlp
                  image: jenkins/inbound-agent
                  tty: true
                  workingDir: /home/jenkins/agent
                  env:
                    - name: JENKINS_URL
                      value: 'http://jenkins-svc:8080'
                    - name: JENKINS_TUNNEL
                      value: 'jenkins-svc:50000'
                
                - name: docker
                  image: docker:20
                  tty: true
                  workingDir: /petclinic
                  volumeMounts:
                    - name: docker-sock
                      mountPath: /var/run/docker.sock
    """
){
    //pipeline code
    node(POD_LABEL){
        container('maven'){
            stage 'CheckOut Code'
            checkout scm

            stage 'Build code'
            sh 'mvn clean package'

            stage 'Publish Artifacts'
            archiveArtifacts allowEmptyArchive: true, artifacts: 'target/*.war', followSymlinks: false, onlyIfSuccessful: true

            stage 'Publish Test Results'
            junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
        }
    }
}