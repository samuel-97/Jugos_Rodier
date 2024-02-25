ABOUT: 
In the mid-1900s, my grandfather, Hugo Rodier, a Chilean-born, 2nd 
generation immigrant of France opened a sandwich and juice shop in Vina del
Mar, Chile near the beach. It would have been popular today for its
fresh-pressed juices and handmade sandwiches. Unfortunately, it burned down
sometime in the 1970s. This is the revamping and reimagining of that shop. 

Here I design and query an SQL database for a simplified and revamped restaurant
that includes a few new menu items that I added. I consulted my father, who spent
most of his childhood working alongside his father in that shop, about what 
items to include or not include. 

LOOSELY BASED ON: 
This project is based in part on a YouTube Tutorial from Adam Finer - Learn BI
Online and his video "Data Analyst Portfolio Project - SQL | Step-by-Step
Guide From SQL Database to Interactive Dashboard", but the data creation is all 
my own original thoughts and ideas.

HOW IT WORKS:
Each folder has accompanying txt or pdf files that outline the processes used to create 
the csvs and design the database. Some outline the errors I encountered and how I fixed them. 

To give you a birds eye view of the project: 
It starts with csvs. I had ChatGPT generate long lists of first names, last names, and street addresses
which I copied into txt files. Then I used Python to create a database that randomly selected from these 
long AI generated lists. 

I consulted with my father on the items to include and used a spreadsheet to design the items, recipe, and 
inventory csvs all manually. They are incredibly simplified and might not all make perfect sense. 

Then to generate the transactions I again used pythons random library to randomly select items and generate 
transaction IDs. 

Then I designed the database. I used quickdbd.com to help me visualize the database and generate a .png image. 
I then created .sql files that allowed me to create the tables and import the csvs that I had created into my new
tables. 

Once the data was successfully loaded, I wrote down the questions that I wanted to answer about my database and 
practiced my querying ninja skills to answer them. 


FUTURE: 
After a Tableau dashboard is created, I may iterate on this project to introduce more complexity into my project using branches. The python code used to create the transactions is fairly simple and I have many ideas on how I can introduce biases and other quirks so that the data can be used for practice.