#!groovy

defaultBuild()

pipeline {
  options { timeout(30) }
  parameters {
    choice(
      name: 'IMAGE',
      choices: [
        "airflow",
        "builder/ruby-2.6",
        "danger",
        "deploy",
        "diff-cover",
        "imposm3",
        "jenkins",
      ]
    )
  }

  agent { kubernetes {} }

  stages {
    stage("Build") {
      parallel {
        stage("airflow") {
          when {
            anyOf {
              changeset "airflow/**/*"
              environment name: 'IMAGE', value: 'airflow'
            }
          }
          steps {
            buildDocker("library/airflow", context: "airflow")
          }
        }

        stage("builder/ruby-2.6") {
          when {
            anyOf {
              changeset "builder/ruby-2.6/**/*"
              expression { params.IMAGE == "builder/ruby-2.6" }
            }
          }
          steps {
            buildDocker("library/builder/ruby-2.6", context: "builder/ruby-2.6")
          }
        }

        stage("danger") {
          when {
            anyOf {
              changeset "danger/**/*"
              expression { params.IMAGE == "danger" }
            }
          }
          steps {
            buildDocker("library/danger", context: "danger")
          }
        }

        stage("deploy") {
          when {
            anyOf {
              changeset "deploy/**/*"
              expression { params.IMAGE == "deploy" }
            }
          }
          steps {
            buildDocker("library/deploy", context: "deploy")
          }
        }

        stage("diff-cover") {
          when {
            anyOf {
              changeset "diff-cover/**/*"
              expression { params.IMAGE == "diff-cover" }
            }
          }
          steps {
            buildDocker("library/diff-cover", context: "diff-cover")
          }
        }

        stage("imposm3") {
          when {
            anyOf {
              changeset "imposm3/**/*"
              expression { params.IMAGE == "imposm3" }
            }
          }
          steps {
            buildDocker("library/imposm3", context: "imposm3")
          }
        }

        stage("jenkins") {
          when {
            anyOf {
              changeset "jenkins/**/*"
              expression { params.IMAGE == "jenkins" }
            }
          }
          steps {
            buildDocker("library/jenkins", context: "jenkins")
          }
        }
      }
    }
  }
}
