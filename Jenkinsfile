// @Library("Shared-Libraries") _
pipeline{
    agent any
  
   tools {
        maven "M3"
    }
	
//     environment {
//        VAULT_CREDS= credentials("vault_id")
//        FILE = 'secret.txt'
//          }
    
    stages{
     
      stage('GIT_Checkout'){
          steps {
              git 'https://github.com/krishnaprasadkeerthi/Ansible-Demo.git'
          }
      }


      stage('Maven_Build'){
         steps {
             sh 'mvn clean install'
         }
      }


        stage('ExecuteSonarQubeReport'){
          steps{
              withSonarQubeEnv('sonarqube8.9'){
                  sh 'mvn sonar:sonar \
                  -Dsonar.projectKey=ansible	 \
			     -Dsonar.projectName=Spring-Boot-Thymeleaf \
			     -Dsonar.host.url=http://43.205.192.62:9000 \
			     -Dsonar.login=sqa_5052c4cfb8102fe574a033ce23017c82a7639778' 
                 }
            }
        }

    //   stage(S_Quality_gates){
    //       steps{
    //           waitForQualityGate abortPipeline: true
    //       }
    //   }


//         stage('NexusArtifactUploader'){
//             steps{
//                 nexusArtifactUploader artifacts: [
//                     [
//                      artifactId: 'spring-boot-thymeleaf',
//                      classifier: '',
//                      file: '/var/lib/jenkins/.m2/repository/pl/codeleak/demos/sbt/spring-boot-thymeleaf/2.0.0/spring-boot-thymeleaf-2.0.0.war',
//                      type: 'war'
//                      ]
//                 ],
//                 credentialsId: 'nexus', 
//                 groupId: 'pl.codeleak.demos.sbt', 
//                 nexusUrl: '52.66.243.13:8081', 
//                 nexusVersion: 'nexus3', 
//                 protocol: 'http', 
//                 repository: 'ansible', 
//                 version: '2.0.0'
//             }
//         }     
     
      
	stage('Terraform'){
	  agent{
	     label 'terraform_agent'
	  }
	  steps{
            sh 'terraform --version'
            sh 'terraform init'
            sh 'terraform validate'
		}
	}

		stage('Terraform-Action'){
	  agent{
	     label 'terraform_agent'
	  }
	  steps{
            sh 'terraform apply -auto-approve'
		}
	}

	    
        stage('Ansible'){
            agent{
                label 'ansible_agent'
            }
            steps{
                    sh 'chmod 400 kavya.pem'            
                    sh 'ansible aws_ec2 -i aws_ec2.yaml -m ping --ssh-common-args="-o StrictHostKeyChecking=no" -u ubuntu --private-key=kavya.pem'
		    sh 'ansible-playbook playbook.yml -i aws_ec2.yaml --ssh-common-args="-o StrictHostKeyChecking=no" -u ubuntu --private-key=kavya.pem'
//		    ansiblePlaybook inventory: 'Inventory', playbook: 'playbook.yml', vaultCredentialsId: 'ansible_vault'
// 		    sh "echo '${VAULT_CREDS_PSW}' > secret.txt"
//    		    sh 'ansible-playbook -i Inventory playbook.yml --vault-password-file cred.yml secret.txt'		    
//   		    sh 'ansible-playbook -i Inventory playbook.yml'
// 		    sh 'ansible-playbook -i Inventory pingServers.yaml'
		                }
        }

	   	    
    }
}
