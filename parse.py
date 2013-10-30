import pickle
import re
obj = pickle.load(open('save.p', 'rb'))
finaldic={}
for w in obj:
    fout = open("htmls/"+w+".txt","r")
    lines = fout.readlines()
    j=''.join(lines).split("\n")
    k=[x for x in j if x !='']
    dic = {}
    for i in ['Course','Title','Instructor','Schedule']:
        q=next(s for s in k if s.startswith(i))
        #print(q)
        #p="".join(c for c in q if c != " ").split(":",1)
        p=q.lstrip().split(":",1)
        #print(p)
        try:
            dic[p[0].lstrip()]=p[1].lstrip()
        except:
            dic[p[0].lstrip]=None
    finaldic[w]=dic
    fout.close() 
print(finaldic)
pickle.dump(finaldic, open('dict.p', 'wb'))
