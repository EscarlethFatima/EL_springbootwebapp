echo 'Stop tomcat service'
sudo systemctl stop tomcat

rm -rf /home/ubuntu/springbootwebapp_deploy
mkdir /home/ubuntu/springbootwebapp_deploy
sudo cp -f /tmp/spring-boot-web-0.0.1-SNAPSHOT-capsule.jar /home/ubuntu/springbootwebapp_deploy/spring-boot-web-0.0.1-SNAPSHOT-capsule.jar
sudo nohup java -jar /home/ubuntu/springbootwebapp_deploy/spring-boot-web-0.0.1-SNAPSHOT-capsule.jar &
