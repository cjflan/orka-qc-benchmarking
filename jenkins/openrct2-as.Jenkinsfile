pipeline {
    agent {
        label "NODE"
    }
    stages {
        stage('Build OpenRCT2') {
            steps { 

                git 'https://github.com/OpenRCT2/OpenRCT2'

                sh 'cmake -S . -B build'
                sh 'cmake --build build --target install'
            }
        }
    }
}
