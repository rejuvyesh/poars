import json
import pickle
obj = pickle.load(open('sublist.p', 'rb'))
with open("save.json", "w") as out: json.dump(obj, out,sort_keys=True, indent=4)
ob = pickle.load(open('dict.p', 'rb'))
with open("dict.json", "w") as outfile: json.dump(ob, outfile,sort_keys=True, indent=4)
