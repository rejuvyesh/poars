JSON2CSV = "node_modules/json2csv/bin/json2csv.js"

all:
	test -e $(JSON2CSV) && $(MAKE) web

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
	$(JSON2CSV) -i  dict.json -f 'Course No','Instructor(s)','Pre-requisites','Schedule','Title','Units' -o "data.csv"

web: csv
	cat head > try.html
	ruby table.rb data.csv >> try.html
	sed -i 's/<tr><th>Course No<\/th><th>Instructor(s)<\/th><th>Pre-requisites<\/th><th>Schedule<\/th><th>Title<\/th><th>Units<\/th><\/tr>/<thead><tr class=\"header\"><th>Course No<\/th><th>Instructor(s)<\/th><th>Pre-requisites<\/th><th>Schedule<\/th><th>Title<\/th><th>Units<\/th><\/tr><\/thead>/g' try.html
	cat foot >> try.html
	git checkout gh-pages
	mv -f try.html index.html
	git add index.html
	git commit -m "`date` update"
	git push origin gh-pages
