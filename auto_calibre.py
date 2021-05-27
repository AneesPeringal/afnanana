##all together
import telebot
from libgen_api import LibgenSearch
import requests
import wget
from bs4 import BeautifulSoup
import os

API_KEY = '501182282:AAH8yf5rehcqk1IImi4ACM5rPM-RPkOGpFs'
bot = telebot.TeleBot(API_KEY)
list_feasible =[]
@bot.message_handler()
def greet(message):
    global list_feasible
    command = message.text[0:5]
    title = message.text[6:]
    chat_id = message.chat.id
    if command == "/book":
        bot.reply_to(message, "I will search the book name: "+ title)
        list_feasible = search(title)
        #tell the user what are the possible options 
    
        for i in range(len(list_feasible)):
            option ="id: "+str(i)+" title: "+list_feasible[i]['Title'] +" author: "+ list_feasible[i]['Author'] +" file_type: "+list_feasible[i]['Extension']
            bot.send_message(chat_id, option)
    elif command == "/down":
        name = download(title)
        bot.reply_to(message, "the requested book has been downloaded")
        os.rename(name,list_feasible[int(title)]['Title'])
        list_feasible =[]
def search(title):
    s = LibgenSearch()
#search in descending order of extension later
    results = s.search_title("Pride and Prejudice")
    global list_feasible
    for i in range(len(results)):
        if results[i]['Extension'] in ['epub','mobi','azw3']:
            list_feasible.append(results[i])
    return(list_feasible)

def download(index):
    global list_feasible
    mirror_url = list_feasible[int(index)]["Mirror_1"]
    mirror_request = requests.get(mirror_url,verify =False)
    soup = BeautifulSoup(mirror_request.content, 'html.parser')
    online_file =soup.findChild("a")['href']
    wget.download(online_file)
    current_name = online_file.split("/")[-1]
    return(current_name)
    
bot.polling()
