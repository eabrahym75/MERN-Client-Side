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
sudo rm -rf MERN-Client-Side || true
git clone https://github.com/eabrahym75/MERN-Client-Side.git
cd memories-client
npm install
rm -rf build
npm run build
sudo pm2 kill
sudo kill $(lsof -nt -i4TCP:3000)
pm2 serve build/ 3000 -f --name "react-build" --spa
sudo rm -rf /etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/ -r
sudo systemctl kill nginx || true
sudo systemctl start nginx