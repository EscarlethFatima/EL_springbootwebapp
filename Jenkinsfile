pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
		sh './gradlew clean assemble'	
            }
	    post {
		success {
			archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
		}
	    }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
		sh './gradlew clean test jacocoTestReport'
            }
	    post {
		always {
			junit 'build/test-results/test/*.xml'
			publishHTML([allowMissing: true,
				   alwaysLinkToLastBuild: false,
				   keepAll: true,
				   reportDir: 'build/reports/tests/test',
				   reportFiles: 'index.html',
				   reportTitles: "Test Report",
				   reportName: 'Junit Report'])
			publishHTML([allowMissing: true,
				   alwaysLinkToLastBuild: false,
				   keepAll: true,
				   reportDir: 'build/reports/jacoco',
				   reportFiles: 'index.html',
				   reportTitles: "Jacoco Report",
				   reportName: 'Jacoco CodeCoverage Report'])
		}
	    }
        }
	stage('CodeQuality'){
	    steps{
		echo 'CodeQuality...'
	        sh './gradlew check sonarqube -Dsonar.organization=escarlethfatima-github -Dsonar.host.url=https://sonarcloud.io -Dsonar.projectKey=my:project155'
	     }
	    post{
                always{
                        publishHTML([allowMissing: true,
                                   alwaysLinkToLastBuild: false,
                                   keepAll: true,
                                   reportDir: 'build/reports/findbugs',
                                   reportFiles: 'main.html',
                                   reportTitles: "FindBugs Report",
                                   reportName: ' Fing Bugs Report'])
                        publishHTML([allowMissing: true,
                                   alwaysLinkToLastBuild: false,
                                   keepAll: true,
                                   reportDir: 'build/reports/pmd',
                                   reportFiles: 'main.html',
                                   reportTitles: "pmd report",
                                   reportName: 'PMD Report'])

                }
            }
			
	}
    }
}
