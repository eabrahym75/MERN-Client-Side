sudo apt-get update
sudo apt-get install git -y
echo "--NODE & NPM--"
sudo apt install nodejs -y
sudo apt install npm -y
echo "-----PM2------"
sudo npm install -g pm2
sudo pm2 startup systemd
echo "-----NGINX------"
sudo apt-get install -y nginx
echo "---FIREWALL---"
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable 
cd /home/ubuntu
sudo rm -rf MERN-Client-Side
git clone https://github.com/eabrahym75/MERN-Client-Side.git
cd MERN-Stack-Server
npm install
sudo rm /etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/ -r
sudo pm2 kill
pm2 start index.js
sudo systemctl kill nginx || true
sudo systemctl restart nginx