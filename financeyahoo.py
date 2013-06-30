#!/usr/bin/env python

import urllib
import os
import time

# loop that checks stock prices every 20 seconds and adds them to the file
while 1:
    # sometimes this program gives me socket errors so if it does skip this itteration of the loop
    try:
        stocks = urllib.urlopen('http://download.finance.yahoo.com/d/quotes.csv?s=%5EDJI+MSFT+F&f=sd1t1l1va2abc1ghk3ops7&e=.csv').read()
    except IOError:
        print ("error reading the socket\n")
        time.sleep(120) #if we don't sleep here loop constently retrys with no delay
        continue

    # if csv doesn't exist create it and write header information
    if os.path.exists('stocks.csv')==0:
        stocksFile = open ( 'stocks.csv', 'a' )
        stocksFile.write("symbol,last trade date,last trade time,last trade price,volume,average daily volume,ask,bid,change,days low,days high,last trade size,open,previous close,short ratio\n")
    stocksFile = open ( 'stocks.csv', 'a' )
    stocksFile.write(stocks)
    stocksFile.close()
    time.sleep(120)
