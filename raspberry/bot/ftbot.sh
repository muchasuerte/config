#!/bin/sh
export FLASK_APP=ft_bot.py
export FLASK_ENV=production
exec ./env/bin/flask run

# uwsgi -s /tmp/yourapplication.sock --manage-script-name --virtualenv /home/andrea/workspace/github/ha-telethon/env --plugin python3 --mount /myapp:app
# uwsgi --plugin python3 --enable-threads  --virtualenv $PWD/env --http-socket 127.0.0.1:5000 --module ft_bot:app
