pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh "ls"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    sh 'echo "master branche"'
                }
            }
        }
    }
}
