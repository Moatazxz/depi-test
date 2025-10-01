
pipeline {
    agent any
   
//    enviroment{
//     registry= "docker.io"

//    }
    stages {

    //    stage('Checkout') {
    //   steps {
    //     cleanWs()  
    //    checkout scm 
    //   }
    // }
    // stage('xx') {
    //   steps {
    //     sh 'git config remote.origin.url https://github.com/Moatazxz/depi-test.git'
    
    //   }
    // }

        stage('build') {
            steps {
             sh """
                  docker build -t docker.io/moatazxz/myapp:v5 .
             """

            }
        }

        stage('push Image') {
            steps {
                 withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                           
                            docker login -u "$DOCKER_USER"  -p "$DOCKER_PASS"
                            docker push docker.io/moatazxz/myapp:latest
                        """
             

            }
        }



    }

}

}



    //         sh 'chmod +x test.sh '
    //         sh './test.sh'

    //   sh '''
                  
    //                docker build -t "${registry}/moatazxz/myapp:latest"  .

    //             '''




