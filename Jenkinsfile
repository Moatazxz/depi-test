
pipeline {
    agent any
   
   enviroment{
    registry= "docker.io"
    reponame= "moatazxz"
    appname= "myapp"

   }
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
                  docker build -t $registry/$reponame/$appname:$BUILD_NUMBER .
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
                            docker push $registry/$reponame/$appname:$BUILD_NUMBER
                        """
             

            }
        }

    }

    // deploy stage 
      
       stage("deploy to remote machine") {

           steps{

          withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
             sshagent(credentials: ['ec2-key']) {
                 
                sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@52.73.12.205 '
                     set -euo pipefail
                     cho "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin docker.io
                     docker run -p 80:80 -d  docker.io/moatazxz/myapp:v5
                     docker ps'
                """


             }


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

// 🔹 2. Predefined (Built-in) Jenkins Environment Variables

// Jenkins gives you many automatic variables you can use. Some of the most useful:

// Variable	Description
// BUILD_ID	Unique build ID (numeric)

// BUILD_NUMBER	Build number for the job

// BUILD_URL	URL of the running build

// JOB_NAME	Name of the Jenkins job

// GIT_COMMIT	The commit hash (if using Git plugin)

// GIT_BRANCH	The branch being built

// WORKSPACE	Path to the Jenkins workspace

// JENKINS_URL	Base URL of Jenkins server

// NODE_NAME	Name of the Jenkins agent node

// EXECUTOR_NUMBER	Executor number running the build






