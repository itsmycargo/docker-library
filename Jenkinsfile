#!groovy

defaultBuild()

pipeline {
  options {
    parameters {
      choice(
        name: 'IMAGES',
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
    timeout(30)
  }

  agent { kubernetes {} }

  stages {
    stage("Build") {
      parallel {
        stage("airflow") {
          when { anyOf { changeset "airflow/**/*"; expression { return params.IMAGES == "airflow" } } }
          steps {
            buildDocker("library/airflow", context: "airflow")
          }
        }

        stage("builder/ruby-2.6") {
          when { changeset "builder/ruby-2.6/**/*" }
          steps {
            buildDocker("library/builder/ruby-2.6", context: "builder/ruby-2.6")
          }
        }

        stage("danger") {
          when { changeset "danger/**/*" }
          steps {
            buildDocker("library/danger", context: "danger")
          }
        }

        stage("deploy") {
          when { changeset "deploy/**/*" }
          steps {
            buildDocker("library/deploy", context: "deploy")
          }
        }

        stage("diff-cover") {
          when { changeset "diff-cover/**/*" }
          steps {
            buildDocker("library/diff-cover", context: "diff-cover")
          }
        }

        stage("imposm3") {
          when { changeset "imposm3/**/*" }
          steps {
            buildDocker("library/imposm3", context: "imposm3")
          }
        }

        stage("jenkins") {
          when { changeset "jenkins/**/*" }
          steps {
            buildDocker("library/jenkins", context: "jenkins")
          }
        }
      }
    }
  }
}
