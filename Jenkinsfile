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
		    sh '''
            sudo cp index-aws.html /var/www/html/index.html
            sudo systemctl restart nginx '''
           }
       } 
       stage("Deploy to azure"){
        steps{
            sh '''
            sudo cp index-aws.html /var/www/html/index.html
            sudo systemctl restart nginx '''
        }
      }
    }
}
