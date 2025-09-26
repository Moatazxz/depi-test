
pipeline {
    agent any
   
//    enviroment{
//     registry= "docker.io"

//    }
    stages {



        stage('build') {
            steps {
             sh '''
                  echo "hello from Build"
             '''

            }
        }

        stage('test') {
            steps {
                sh '''
                  echo "hello from test"
             '''
            }
        }

       stage('dockerImage') {
            steps {
                sh '''
                  echo "hello from docker image"
             '''
            }
        }



    }

}





    //         sh 'chmod +x test.sh '
    //         sh './test.sh'

    //   sh '''
                  
    //                docker build -t "${registry}/moatazxz/myapp:latest"  .

    //             '''
