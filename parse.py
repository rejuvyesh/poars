import pickle
obj = pickle.load(open('sublist.p', 'rb'))
finaldic = []
for w in obj:
    fout = open("data/"+w+".txt", "r")
    lines = fout.readlines()
    j = ''.join(lines).split("\n")
    k = [x for x in j if x != '']
    k = list(map(lambda x: x.strip(), k))
    dic = {}
    for i in ['Course', 'Title', 'Instructor', 'Schedule', 'Units', 'Pre', 'Department', 'Inst']:
        q = next(s for s in k if s.startswith(i))
        print(q)
        #p="".join(c for c in q if c != " ").split(":",1)
        p = q.lstrip().split(":", 1)
        print(p)
        try:
            dic[p[0].lstrip()] = p[1].lstrip()
        except:
            dic[p[0].lstrip] = None
    finaldic.append(dic)
    fout.close()
print(finaldic)
pickle.dump(finaldic, open('dict.p', 'wb'))
