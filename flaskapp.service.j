[Unit]
Description=Flask application
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/flask-app-project
Environment="PATH=/home/ubuntu/flaskenv/bin"
ExecStart=/home/ubuntu/flaskenv/bin/python /home/ubuntu/flask-app-project/app.py
Restart=always

[Install]
WantedBy=multi-user.target
