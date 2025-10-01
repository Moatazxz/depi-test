
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

     // Build Stage
        stage('build') {
            steps {
             sh """
                  docker build -t docker.io/moatazxz/myapp:v5 .
                  docker images
             """

            }
        }

        stage('push Image') {
            steps {
                 withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                           
                            # docker login -u "$DOCKER_USER"  -p "$DOCKER_PASS"
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin docker.io
                            docker push docker.io/moatazxz/myapp:v5
                        """
             

            }
        }

    }

    // deploy stage 
      
       stage("deploy to remote machine") {

           steps{
             sshagent(credentials: ['ec2-key']) {
                 
                sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@52.73.12.205 '
                     set -euo pipefail
                     docker pull docker.io/moatazxz/myapp:v5
                     docker run -p 80:80 -d  docker.io/moatazxz/myapp:v5
                     docker ps'
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









