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

  stage("Wolfhound") {
    steps { wolfhound() }
  }
}
