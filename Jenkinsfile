pipeline{
    agent any
    stages{
     stage("Deplo to AWS"){
        steps{
		    sh """
                       whoami 
                       ssh -T -o StrictHostKeyChecking=no -i /var/lib/jenkins/project.pem ubuntu@52.200.204.207 '
					   rm -rf /home/ubuntu/capstone
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
			sshpass -p Password1234! ssh -T -o StrictHostKeyChecking=no testadmin@52.170.187.23 '
            rm -rf /home/testadmin/capstone
            git clone https://github.com/ualla3011/capstone.git
			ls -ltr /home/testadmin/capstone/index-azure.html
            sudo cp /home/testadmin/capstone/index-azure.html /var/www/html/index.html
            sudo systemctl restart nginx '
			"""
        }
      }
    }
}
