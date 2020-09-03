#!groovy

defaultBuild()

pipeline {
  options {
    podTemplate(inheritFrom: "default")
    preserveStashes()
    skipDefaultCheckout()
    timeout(60)
  }

  agent none

  stages {
    stage("Wolfhound") {
      steps { wolfhound() }
    }

    stage("Build") {
      parallel {
        stage("airflow") {
          when { changeset "/airflow/**" }
          steps {
            dockerBuild(dir: "/airflow", image: "library/airflow")
          }
        }

        stage("builder") {
          when { changeset "/builder/**" }
          steps {
            dockerBuild(dir: "/builder", image: "library/builder")
          }
        }

        stage("builder/node") {
          when { changeset "/builder/node/**" }
          steps {
            dockerBuild(dir: "/builder/node", image: "library/builder/node")
          }
        }

        stage("builder/ruby-2.6") {
          when { changeset "/builder/ruby-2.6/**" }
          steps {
            dockerBuild(dir: "/builder/ruby-2.6", image: "library/builder/ruby-2.6")
          }
        }

        stage("builder/ruby-2.6-alpine") {
          when { changeset "/builder/ruby-2.6-alpine/**" }
          steps {
            dockerBuild(dir: "/builder/ruby-2.6-alpine", image: "library/builder/ruby-2.6-alpine")
          }
        }

        stage("danger") {
          when { changeset "/danger/**" }
          steps {
            dockerBuild(dir: "/danger", image: "library/danger")
          }
        }

        stage("deploy") {
          when { changeset "/deploy/**" }
          steps {
            dockerBuild(dir: "/deploy", image: "library/deploy")
          }
        }

        stage("diff-cover") {
          when { changeset "/diff-cover/**" }
          steps {
            dockerBuild(dir: "/diff-cover", image: "library/diff-cover")
          }
        }

        stage("imposm3") {
          when { changeset "/imposm3/**" }
          steps {
            dockerBuild(dir: "/imposm3", image: "library/imposm3")
          }
        }

        stage("jenkins") {
          when { changeset "/jenkins/**" }
          steps {
            dockerBuild(dir: "/jenkins", image: "library/jenkins")
          }
        }

        stage("postgis-review") {
          when { changeset "/postgis-review/**" }
          steps {
            dockerBuild(dir: "/postgis-review", image: "library/postgis-review")
          }
        }

      }
    }
  }
}
