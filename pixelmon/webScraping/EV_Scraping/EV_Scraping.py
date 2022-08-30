# .\venv\Scripts\activate for Virtual Environment

from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import csv

# Scrape the HTML from the website
req = Request(
    url='https://pixelmonmod.com/wiki/EV_yield', 
    headers={'User-Agent': 'Mozilla/5.0'}
)
webpage = urlopen(req).read()

# Convert it into HTML format
soup = BeautifulSoup(webpage, "html.parser")
# Get results from only the table
results = soup.find("tbody")
# Get a list of pokemon and EV drops
pokemonList = results.find_all("tr")

with open('EV_Data.csv', 'w', encoding='UTF8', newline='') as f:
    writer = csv.writer(f)
    
    for pokemon in pokemonList:
        tempList = []
        
        pokemonTitle = pokemon.find_all("th")
        if len(pokemonTitle) != 0:
            tempList = []
        
            for data in pokemonTitle:
                tempList.append(data.text.replace("\n", ""))
                
            writer.writerow(tempList)
            continue
        
        pokemonInfo = pokemon.find_all("td")
        for data in pokemonInfo:
            tempList.append(data.text.replace("\n", ""))
            
        writer.writerow(tempList)
        