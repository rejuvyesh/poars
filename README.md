Saner OARS
==========

What's this?
------------

A toolchain to scrape the OARS website to generate a clean course listing.
Works inside iitk only.

Usage
-----

```
git clone https://github.com/rejuvyesh/poars
cd poars
npm install json2csv
make
```
You'll probably need to install `elinks` as well.

About
-----

[`poars.py`](https://github.com/rejuvyesh/poars/blob/master/poars.py): Scrapes data from OARS and saves as html.

[`check.rb`](https://github.com/rejuvyesh/poars/blob/master/check.rb): Checks and removes empty htmls.

[`dump.rb` ](https://github.com/rejuvyesh/poars/blob/master/dump.rb): Dumps html files to text.

[`parse.py`](https://github.com/rejuvyesh/poars/blob/master/parse.py): Parses the text files to generate a dictionary of all data.

[`jsn.py`  ](https://github.com/rejuvyesh/poars/blob/master/jsn.py): Dumps the python dictionary as json.



See in action at: http://rejuvyesh.com/poars/
