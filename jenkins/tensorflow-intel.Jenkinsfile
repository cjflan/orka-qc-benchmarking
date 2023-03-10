pipeline {
    agent none
    stages {
        stage("Build Tensorflow") {
            agent {
                label "parallel-tensorflow-intel"
            }
            environment {
                PYENV_ROOT="$HOME/.pyenv"
                PATH="$PYENV_ROOT/shims:/usr/local/bin:$PATH"
            }
            steps {
                sh '''
                    pyenv init -
                    pyenv global 3.11.2
                '''
                
                sh 'python --version'

                git branch: "master",
                    url: "https://github.com/tensorflow/tensorflow.git"

                sh '''
                    pip install --upgrade pip
                    pip install -r ./tensorflow/tools/ci_build/release/requirements_mac.txt
                '''
                
                sh 'yes "" | python configure.py'

                echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
                sh "cat .tf_configure.bazelrc"
                echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"

                
                sh 'bazel build //tensorflow/tools/pip_package:build_pip_package'

                }
            }
        }
    }
