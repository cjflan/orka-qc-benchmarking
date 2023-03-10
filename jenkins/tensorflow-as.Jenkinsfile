pipeline {
    agent none

    stages {
        stage("Build Tensorflow") {
            agent {
                label "LABEL"
            }
            environment {
                PYENV_ROOT="$HOME/.pyenv"
                PATH="$PYENV_ROOT/shims:/opt/homebrew/bin/:$PATH"
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
                    python tensorflow/tools/ci_build/update_version.py --nightly
                '''
                
                sh 'yes "" | python configure.py'

                echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
                sh "cat .tf_configure.bazelrc"
                echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"

                sh '''
                    /opt/homebrew/bin/bazel build \
                    --action_env PYTHON_LIB_PATH="/Users/admin/.pyenv/versions/3.11.2/lib/python3.11/site-packages" \
                    --config=macos_arm64 \
                    //tensorflow/tools/pip_package:build_pip_package
                    '''
            }
        }
    }
}
