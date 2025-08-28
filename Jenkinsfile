pipeline{
    agent any
    stages{
        stage("clone repository"){
	    steps{
		    git branch: 'main',url:'https://github.com/ualla3011/capstone.git'
			}  
		   }	
	stage("Deplo to AWS"){
        steps{
		    sh """
                       whoami 
                       ssh -T -o StrictHostKeyChecking=no -i /var/lib/jenkins/project.pem ubuntu@3.93.59.53 '
                       git clone https://github.com/ualla3011/capstone.git
					   ls -ltr /home/ubuntu/capstone/index-aws.html
                       sudo cp /home/ubuntu/capstone/index-aws.html /var/www/html/index.html
                       sudo systemctl restart nginx '
              """
		   }
       } 
       stage("Deploy to azure"){
        steps{
            sh """
			sshpass -p Password1234! ssh -T -o StrictHostKeyChecking=no testadmin@172.190.164.2 '
            git clone https://github.com/ualla3011/capstone.git
			ls -ltr /home/testadmin/capstone/index-azure.html
            sudo cp /home/testadmin/capstone/index-azure.html /var/www/html/index.html
            sudo systemctl restart nginx '
			"""
        }
      }
    }
}
