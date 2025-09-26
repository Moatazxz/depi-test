
pipeline {
    agent any
   
//    enviroment{
//     registry= "docker.io"

//    }
    stages {



        stage('build') {
            steps {
             sh ```
                  docker build -t docker.io/moatazxz/myapp:v5 .
             ```

            }
        }

        stage('push Image') {
            steps {
                 withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            // echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin docker.io
                            docker login -u "$DOCKER_USER"  -p "$DOCKER_PASS"
                            docker push docker.io/moatazxz/myapp:latest
                        """
             
            }
        }



    }

}





    //         sh 'chmod +x test.sh '
    //         sh './test.sh'

    //   sh '''
                  
    //                docker build -t "${registry}/moatazxz/myapp:latest"  .
    //             '''