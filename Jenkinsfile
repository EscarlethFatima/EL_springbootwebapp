pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
		sh './gradlew clean assemble'	
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
	stage('Package') {
            steps {
                sh './gradlew build capsule'              
            }	
	    post {
                success {
                    archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
                }
            }
        }
     stage('Deploy'){
        steps{
            sh './gradlew -b deploy.gradle deploy -Pdev_server=10.28.135.216 -Puser_server=ubuntu -Pkey_path=/home/devops.pem -Pjar_path=build/libs -Pjar_name=spring-boot-web-0.0.1-SNAPSHOT-capsule'
        }
     }
	 stage('Acceptance'){
		steps{
			sh '.acceptance_test/gradlew clean test allureReport -p acceptance_test/'
		}
		post{
             always{
                    publishHTML([allowMissing: true,
                                   alwaysLinkToLastBuild: false,
                                   keepAll: true,
                                   reportDir: 'acceptance_test/build/reports/cucumber-reports/cucumber-html-reports',
                                   reportFiles: 'report-feature_gradle-cucumber-features-gradle-feature.html',
                                   reportTitles: "Cucumber Report",
                                   reportName: 'Cucumber Html Report'])
                    publishHTML([allowMissing: true,
                                   alwaysLinkToLastBuild: false,
                                   keepAll: true,
                                   reportDir: 'acceptance_test/build/allure-results',
                                   reportFiles: 'index.html',
                                   reportTitles: "Allure Report",
                                   reportName: 'Allure Html Report'])

             }
        }
	  }
    }
}
