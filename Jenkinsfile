pipeline {
    agent any

    tools {
        maven "M3"
    }

    stages {

        stage('GIT CheckOut') {
            steps {
                git 'https://github.com/krishnaprasadkeerthi/Ansible-Demo.git' 
                            }
        }

    
        stage('MavenBuild') {
            steps {
                sh 'mvn clean install'    
                            }
        }

        stage('ExecuteSonarQubeReport'){
          steps{
              withSonarQubeEnv('sonarqube8.9'){
                  sh 'mvn sonar:sonar \
                  -Dsonar.projectKey=Spring-Boot-Thymeleaf	 \
			      -Dsonar.projectName=Spring-Boot-Thymeleaf \
			      -Dsonar.host.url=http://3.110.181.217:9000 \
			      -Dsonar.login=sqa_96900a1eac0bf3015be27b9eedd23da740121c6e'
                 }
            }
        }
     
        stage('NexusArtifactUploader'){
            steps{
                nexusArtifactUploader artifacts: [
                    [
                     artifactId: 'spring-boot-thymeleaf',
                     classifier: '',
                     file: '/var/lib/jenkins/.m2/repository/pl/codeleak/demos/sbt/spring-boot-thymeleaf/2.0.0/spring-boot-thymeleaf-2.0.0.war',
                     type: 'war'
                     ]
                ],
                credentialsId: 'nexus', 
                groupId: 'pl.codeleak.demos.sbt', 
                nexusUrl: '13.233.100.229:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'ansible', 
                version: '2.0.0'
            }
        }

/*
        stage('Tomcat Deploy Through Ansible Roles') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'PASSWORD', usernameVariable: 'USER')]) {
                         sh "ansible-playbook -i inventory playbook.yml -u ansible"
                         }
                   }
        }
*/

        }
    }
