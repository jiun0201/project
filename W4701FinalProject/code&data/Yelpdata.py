import json;
'''
data1 = {'b':789,'c':456,'a':123}
data2 = {'a':123,'b':789,'c':456}
d1 = json.dumps(data1,sort_keys=True)
d2 = json.dumps(data2)
d3 = json.dumps(data2,sort_keys=True)
print d1
print d2
print d3
print d1==d2
print d1==d3
print data1.has_key('b')
print data1.has_key('d')


s = json.loads('{"name":"test", "type":{"name":"seq", "parameter":["1", "2"]}}')
print s
print s.keys()
print s["name"]
print s["type"]["name"]
print s["type"]["parameter"][0]
print s["type"]["parameter"][1]


s = json.load(file('/Users/songshiyu/Downloads/yelp_phoenix_academic_dataset/test.json'))  
print s
print s.keys()
print s["type"]
print s["business_id"]
print s["checkin_info"].keys()


f=file('/Users/songshiyu/Downloads/yelp_phoenix_academic_dataset/test2.json') 
result= f.readlines()
print len(result)
i=1
for s in result:
    if i==len(result):
        break
    print i
    i=i+1
    print s
    if s!=None:
        sa=json.loads(s)
        print sa["type"]
        print sa["business_id"]

fileHandle = open ( '/Users/songshiyu/Desktop/test.txt', 'w' )
fileHandle.write ( 'This' )
fileHandle.write ( ' ' )
fileHandle.write ( 'fuck' )
fileHandle.write ( '\n' )
fileHandle.write ( 'caonima' )
fileHandle.close() 
'''

'''
#checkin
fileHandle = open ( '/Users/songshiyu/Desktop/checkin.txt', 'w' )
f=file('/Users/songshiyu/Downloads/yelp_phoenix_academic_dataset/yelp_academic_dataset_checkin.json')
result= f.readlines()
print len(result)

i=1
for s in result:
    if i==len(result):
        break
    fileHandle.write ( str(i) )
    fileHandle.write ( ' ' )
    i=i+1
    if s!=None:
        sa=json.loads(s)
        fileHandle.write ( sa["type"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["business_id"])
        fileHandle.write ( '\n' )
fileHandle.close()
'''
'''
#review
fileHandle = open ( '/Users/songshiyu/Desktop/review.txt', 'w' )
f=file('/Users/songshiyu/Downloads/yelp_phoenix_academic_dataset/yelp_academic_dataset_review.json')
result= f.readlines()
print len(result)-1

i=1
for s in result:
    fileHandle.write (str(i))
    fileHandle.write (' ')
    i=i+1
    if s!=None:
        sa=json.loads(s)
        fileHandle.write ( sa["type"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["business_id"])
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["user_id"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( str(sa["stars"]) )
        fileHandle.write ( ' ' )
        #fileHandle.write ( str(sa["text"] ))
        #fileHandle.write ( ' ' )
        fileHandle.write ( sa["date"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( str(sa["votes"]["funny"]) )
        fileHandle.write ( ' ' )
        fileHandle.write ( str(sa["votes"]["useful"]) )
        fileHandle.write ( ' ' )
        fileHandle.write ( str(sa["votes"]["cool"]) )
        fileHandle.write ( '\n' )
fileHandle.close()
'''
'''
#tip
fileHandle = open ( '/Users/songshiyu/Desktop/tip.txt', 'w' )
f=file('/Users/songshiyu/Downloads/yelp_phoenix_academic_dataset/yelp_academic_dataset_tip.json')
result= f.readlines()
print len(result)-1

i=1
for s in result:
    fileHandle.write (str(i))
    fileHandle.write (' ')
    i=i+1
    if s!=None:
        sa=json.loads(s)
        fileHandle.write ( sa["type"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["business_id"])
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["user_id"] )
        fileHandle.write ( ' ' )
        #fileHandle.write ( sa["text"] )
        #fileHandle.write ( ' ' )
        fileHandle.write ( sa["date"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( str(sa["likes"]))
        fileHandle.write ( '\n' )
fileHandle.close()
'''

fileHandle = open ( '/Users/songshiyu/Desktop/business.txt', 'w' )
f=file('/Users/songshiyu/Downloads/yelp_phoenix_academic_dataset/yelp_academic_dataset_business.json')
result= f.readlines()
print len(result)-1

i=1
for s in result:
    fileHandle.write (str(i))
    fileHandle.write (' ')
    i=i+1
    if i==len(result):
        break
    if s!=None:
        sa=json.loads(s)
        fileHandle.write ( sa["type"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["business_id"])
        fileHandle.write ( ' ' )
        #fileHandle.write ( sa["name"] )
        #fileHandle.write ( ' ' )
        fileHandle.write ( sa["city"] )
        fileHandle.write ( ' ' )
        fileHandle.write ( sa["state"] )
        fileHandle.write ( ' ' )
        fileHandle.write (str(sa["latitude"] ))
        fileHandle.write ( ' ' )
        fileHandle.write (str(sa["longitude"]))
        fileHandle.write ( ' ' )
        fileHandle.write (str(sa["stars"]))
        fileHandle.write ( ' ' )
        fileHandle.write (str(sa["review_count"]))
        fileHandle.write ( ' ' )
        fileHandle.write (str(sa["categories"]))
        fileHandle.write ( ' ' )
        #fileHandle.write ( str(sa["open"]))
        #fileHandle.write ( ' ' )
        #fileHandle.write ( str(sa["hours"]))
        #fileHandle.write ( ' ' )
        
        #accept credit cards
        if sa["attributes"].has_key("Accepts Credit Cards")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Accepts Credit Cards"]))
        fileHandle.write ( ' ' )
        #price range
        if sa["attributes"].has_key("Price Range")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Price Range"]))
        fileHandle.write ( ' ' )
        #Take-out
        if sa["attributes"].has_key("Take-out")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Take-out"]))
        fileHandle.write ( ' ' )
        #Wi-Fi
        if sa["attributes"].has_key("Wi-Fi")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Wi-Fi"]))
        fileHandle.write ( ' ' )
        #Takes Reservations
        if sa["attributes"].has_key("Takes Reservations")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Takes Reservations"]))
        fileHandle.write ( ' ' )
        #Has TV
        if sa["attributes"].has_key("Has TV")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Has TV"]))
        fileHandle.write ( ' ' )
        #Delivery
        if sa["attributes"].has_key("Delivery")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Delivery"]))
        fileHandle.write ( ' ' )
        #Outdoor Seating
        if sa["attributes"].has_key("Outdoor Seating")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Outdoor Seating"]))
        fileHandle.write ( ' ' )
        #Attire
        if sa["attributes"].has_key("Attire")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Attire"]))
        fileHandle.write ( ' ' )
        #Waiter Service
        if sa["attributes"].has_key("Waiter Service")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Waiter Service"]))
        fileHandle.write ( ' ' )
        #Good for Kids
        if sa["attributes"].has_key("Good for Kids")!=True:
            fileHandle.write ("?")
        else:
            fileHandle.write ( str(sa["attributes"]["Good for Kids"]))
        fileHandle.write ( ' ' )
        #Parking
        if sa["attributes"].has_key("Parking")!=True:
            fileHandle.write ("?")
            fileHandle.write (' ')
            fileHandle.write ("?")
            fileHandle.write (' ')
            fileHandle.write ("?")
            fileHandle.write (' ')
            fileHandle.write ("?")
            fileHandle.write (' ')
            fileHandle.write ("?")            
        else:
            if sa["attributes"]["Parking"].has_key("none")==True:
                continue
            fileHandle.write (str(sa["attributes"]["Parking"]["garage"]))
            fileHandle.write (' ')
            fileHandle.write (str(sa["attributes"]["Parking"]["street"]))
            fileHandle.write (' ')
            fileHandle.write (str(sa["attributes"]["Parking"]["validated"]))
            fileHandle.write (' ')
            fileHandle.write (str(sa["attributes"]["Parking"]["lot"]))
            fileHandle.write (' ')
            fileHandle.write (str(sa["attributes"]["Parking"]["valet"]))
        fileHandle.write ( '\n' )
fileHandle.close()

