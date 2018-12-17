import sys
import pickle
import logging
from threading import Thread
from functools import wraps
import subprocess
from subprocess import check_output

import telegram
from telegram.ext import Updater
from telegram.ext import CommandHandler
from telegram.ext import MessageHandler, Filters

from flask import Flask

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    with open('telegram.token') as t:
        TOKEN = t.read().strip()
except Exception as ex:
    logger.info('missing telegram.token')
    sys.exit(-1)

LIST_OF_ADMINS = []
try:
    with open('telegram.admin') as t:
        for x in t.readlines():
            LIST_OF_ADMINS.append(int(x.strip()))
except Exception as ex:
    logger.info('missing telegram.admin')
    sys.exit(-1)

def restricted(func):
    @wraps(func)
    def wrapped(bot, update, *args, **kwargs):
        user_id = update.effective_user.id
        if user_id not in LIST_OF_ADMINS:
            print("Unauthorized access denied for {}.".format(user_id))
            return
        return func(bot, update, *args, **kwargs)
    return wrapped

updater = Updater(token=TOKEN)
dispatcher = updater.dispatcher
bot = dispatcher.bot
app = Flask(__name__)

@app.route('/')
def welcome():
    return "Welcome to Flask Telegram bot!"

@app.route('/lost_power')
def lost_power():
    idlist = []
    try:
        with open('pickle.db', 'br') as fd:
            idlist = pickle.load(fd)
    except Exception as ex:
        logger.error(ex)

    for cid in idlist:
        logger.info('callback_minute!' + str(cid))
        bot.send_message(
            chat_id=cid,
            text='lost power')
    return "done!"


@app.route('/power_on')
def power_on():
    idlist = []
    try:
        with open('pickle.db', 'br') as fd:
            idlist = pickle.load(fd)
    except Exception as ex:
        logger.error(ex)

    for cid in idlist:
        logger.info('callback_minute!' + str(cid))
        bot.send_message(
            chat_id=cid,
            text='power_on!')
    return "done!"


@restricted
def echo(bot, update):
    logger.info(update.effective_user.username)
    logger.info(update.effective_user.id)
    logger.info(update.message.text)
    bot.send_message(chat_id=update.message.chat_id, text=update.message.text)

echo_handler = MessageHandler(Filters.text, echo)
dispatcher.add_handler(echo_handler)

@restricted
def ups(bot, update):
    """

    :param bot: (telegram.bot)
    :param update: (telegram.Updater)
    :return:
    """
    custom_keyboard = [
            ['/info'],
            ['/start'],
            ['/status']
        ]
    logger.info(update)
    reply_markup = telegram.ReplyKeyboardMarkup(custom_keyboard)
    bot.send_message(chat_id=update.message.chat_id,
                    text="Custom Keyboard Test",
                    reply_markup=reply_markup)

ups_handler = CommandHandler('ups', ups)
dispatcher.add_handler(ups_handler)

@restricted
def info(bot, update):
    """

    :param bot: (telegram.bot)
    :param update: (telegram.Updater)
    :return:
    """
    logger.info(update)
    bot.send_message(chat_id=update.message.chat_id,
                    text="info")

info_handler = CommandHandler('info', info)
dispatcher.add_handler(ups_handler)

@restricted
def status(bot, update):
    """

    :param bot: (telegram.bot)
    :param update: (telegram.Updater)
    :return:
    """
    output = check_output("apcaccess status", stderr=subprocess.STDOUT, shell=True)
    bot.send_message(chat_id=update.message.chat_id,
                    text=str(output))

status_handler = CommandHandler('status', status)
dispatcher.add_handler(status_handler)


def error(bot, update, error):
    """Log Errors caused by Updates."""
    logger.warning('Update "%s" caused error "%s"', update, error)

# log all errors
dispatcher.add_error_handler(error)


if __name__ == '__main__':
    thr = Thread(target=app.run)
    thr.start()

    updater.start_polling()
    # Block until you press Ctrl-C or the process receives SIGINT, SIGTERM or
    # SIGABRT. This should be used most of the time, since start_polling() is
    # non-blocking and will stop the bot gracefully.
    updater.idle()
else:
    thr = Thread(target=updater.start_polling)
    thr.start()
