#!groovy

@Library("common@cleanup") _

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

    stage("Prepare") {
      steps {
        defaultCheckout()
      }
    }
  }
}
