JSON2CSV = "node_modules/json2csv/bin/json2csv.js"

all:
	test -e $(JSON2CSV) && $(MAKE) json && $(MAKE) web

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

csv: dict.json
	$(JSON2CSV) -i  dict.json -f 'Department','Course No','Instructor(s)','Pre-requisites','Schedule','Title','Units','Inst. email' -o "data.csv"

web: csv
	sed -i 's/(L-T-P-D-U)//g' data.csv
	sed -i 's/@iitk.ac.in//g' data.csv
	sed -i 's/\<bandopa\>/abandopa/g' data.csv
	cat head > data/try.html
	ruby table.rb data.csv >> data/try.html
	sed -i 's/<table><tr><th>Department<\/th><th>Course No<\/th><th>Instructor(s)<\/th><th>Pre-requisites<\/th><th>Schedule<\/th><th>Title<\/th><th>Units<\/th><th>Inst. email<\/th><\/tr>/<table id=\"ctable\" class=\"table table-striped table-bordered\"><thead><tr class=\"header\"><th>Department<\/th><th>Course No<\/th><th>Instructor(s)<\/th><th>Pre-requisites<\/th><th>Schedule<\/th><th>Title<\/th><th>Units<\/th><th>Inst. email<\/th><\/tr><\/thead>/g' data/try.html
	cat foot >> data/try.html

pub: data/try.html
	if ! git diff-index --quiet HEAD --; then \
		git add save.json dict.json; \
		git commit -m 'update json'; \
	fi 
	cp -f dict.json newdict.json
	git checkout gh-pages
	mv -f data/try.html index.html
	mv -f newdict.json dict.json
	git add index.html dict.json
	git commit -m "`date` update"
	git push origin gh-pages
	git push navya '+gh-pages:refs/heads/master'
	git checkout master
