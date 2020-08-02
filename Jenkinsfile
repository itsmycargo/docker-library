#!groovy

@Library('common@changeset') _

defaultBuild()

def images = []

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

    stage("Prepare") {
      agent { kubernetes {} }
      steps {
        checkout scm

        dockerBuilder.discover(glob: "Dockerfile")
      }
    }

    // stage("Build") {
    //   parallel {
    //     stage("airflow") { steps { dockerBuild(dir: "airflow/", image: "library/airflow") } }
    //     stage("builder/node") { steps { dockerBuild(dir: "builder/node", image: "library/builder/node") } }
    //     stage("builder/ruby-2.6") { steps { dockerBuild(dir: "builder/ruby-2.6", image: "library/builder/ruby-2.6") } }
    //     stage("danger") { steps { dockerBuild(dir: "danger", image: "library/danger") } }
    //     stage("deploy") { steps { dockerBuild(dir: "deploy", image: "library/deploy") } }
    //     stage("diff-cover") { steps { dockerBuild(dir: "diff-cover", image: "library/diff-cover") } }
    //     stage("imposm3") { steps { dockerBuild(dir: "imposm3", image: "library/imposm3") } }
    //     stage("jenkins") { steps { dockerBuild(dir: "jenkins", image: "library/jenkins") } }
    //   }
    // }
  }
}
