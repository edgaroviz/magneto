#!/usr/bin/python

import time
from flask import Flask

app = Flask(__name__)

# Start time of the application
START = time.time()


# Function to calculate uptime in hours, minutes, and seconds
def uptime():
    running = time.time() - START
    hours, remainder = divmod(running, 3600)
    minutes, seconds = divmod(remainder, 60)
    return int(hours), int(minutes), int(seconds)


@app.route('/')
def root():
    hours, minutes, seconds = uptime()
    uptime_str = f"{hours} hours, {minutes} minutes, {seconds} seconds"
    return f"""
     <!DOCTYPE html>
     <html lang="en">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Flask Uptime</title>
         <style>
             body {{
                 font-family: Arial, sans-serif;
                 background-color: #f0f0f0;
                 margin: 0;
                 padding: 0;
             }}
             .container {{
                 max-width: 800px;
                 margin: 20px auto;
                 padding: 20px;
                 background-color: #fff;
                 border-radius: 8px;
                 box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
             }}
             h1 {{
                 text-align: center;
                 color: #333;
             }}
             p {{
                 text-align: center;
                 font-size: 1.2em;
                 color: #666;
             }}
         </style>
     </head>
     <body>
         <div class="container">
             <h1>Welcome to My Flask App!</h1>
             <p>Server uptime: {uptime_str}</p>
         </div>
     </body>
     </html>
     """


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
