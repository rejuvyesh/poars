JSON2CSV = "node_modules/json2csv/bin/json2csv.js"

all:
	test -e $(JSON2CSV) && $(MAKE) web

scrape: poars.py
	python poars.py
	ruby check.rb
	python poars.py

txt: scrape dump.rb
	ruby dump.rb
	rm -rf data/
	mkdir -p data
	rm -f data.txt sorted.txt
	cp -r *.txt data/

dict: txt parse.py
	python parse.py

json: dict jsn.py
	python jsn.py

csv: json
	$(JSON2CSV) -i  dict.json -f 'Course No','Instructor(s)','Pre-requisites','Schedule','Title','Units' -o "data.csv"

web: csv
	sed -i 's/(L-T-P-D-U)//g' data.csv
	cat head > try.html
	ruby table.rb data.csv >> try.html
	sed -i 's/<tr><th>Course No<\/th><th>Instructor(s)<\/th><th>Pre-requisites<\/th><th>Schedule<\/th><th>Title<\/th><th>Units<\/th><\/tr>/<thead><tr class=\"header\"><th>Course No<\/th><th>Instructor(s)<\/th><th>Pre-requisites<\/th><th>Schedule<\/th><th>Title<\/th><th>Units<\/th><\/tr><\/thead>/g' try.html
	cat foot >> try.html

pub: try.html
	if ! git diff-index --quiet HEAD --; then \
		git add save.json dict.json; \
		git commit -m 'update json'; \
	fi 
	cp -f dict.json newdict.json
	git checkout gh-pages
	mv -f try.html index.html
	mv -f newdict.json dict.json
	git add index.html dict.json
	git commit -m "`date` update"
	git push origin gh-pages
