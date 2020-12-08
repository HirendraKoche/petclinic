podTemplate(
    containers: [containerTemplate(command: 'cat', image: 'maven:3-alpine', name: 'maven', ttyEnabled: true)] 
 ){
    node(POD_LABEL){
        stage 'CheckOut Code'
        checkout scm

        stage 'Build Code'
        container('maven'){ 
            sh 'mvn clean package'
        }
    }
}