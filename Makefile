all: web

scrape: poars.py
	python poars.py
txt: scrape dump.rb
	ruby dump.rb
	rm -rf data/
	mkdir -p data
	cp -r *.txt data/
dict: txt parse.py
	python parse.py
json: dict jsn.py
	python jsn.py
csv: json
	json2csv -i  dict.json -f 'Course No','Instructor(s)','Pre-requisites','Schedule','Title','Units' -o "data.csv"
web: csv
	cat head > try.html
	ruby table.rb data.csv >> try.html
	cat foot >> try.html
	git checkout gh-pages
	mv -f try.html index.html
  git add index.html
	git commit -m "`date` update"
	git push origin gh-pages
