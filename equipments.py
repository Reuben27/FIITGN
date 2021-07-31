import time
import tkinter as tk
import pprint

def initialize():
    global sport_unique_id
    global equipment_unique_id
    global equipment_slot
    global display_slot

    sport_unique_id = {"Table Tennis": 0,
                       "Squash": 1,
                       "Football": 2,
                       "Cricket": 3}

    equipment_unique_id = {"TT Rackets": 0,
                           "TT Balls": 1,
                           "Squash Rackets": 2,
                           "Squash Balls": 3,
                           "Footballs": 4,
                           "Cones": 5,
                           "Stumps": 6,
                           "Gloves": 7,
                           "Bat": 8,
                           "Cricket Balls": 9}

    for i in equipment_unique_id.keys():
        key = i
        equipment_slot[key] = []
        display_slot[key] = []


#######################################################################################################################
#######################################################################################################################
def load_total_quantities():    

    Table_Tennis = {"TT Rackets" : 10,
                    "TT Balls" : 50}

    Squash = {"Squash Rackets": 6,
              "Squash Balls": 30}

    Football = {"Footballs": 5,
                "Cones": 40}

    Cricket = {"Stumps" : 15,
                "Gloves": 7,
                "Bat": 4,
                "Cricket Balls": 17}

    global sports
    sports = [Table_Tennis, Squash, Football, Cricket]



#######################################################################################################################
#######################################################################################################################
def entry():
    r_type = input("What do you want to book ?\n")
    print()

    print("Format for entering time is......")
    print("d m y, hr:min")
    print("NOTE - Add ZEROS if needed!")
    print("NOTE - Enter time in 24hrs format!")
    print("NOTE - Write complete month name!")
    print("Sample Input: 01 February 2021, 00:00\n")

    start_ = input("Enter starting date and time.\n")
    print()
    end_ = input("Enter ending date and time.\n")
    print()
    t = time.strptime(start_, "%d %B %Y, %H:%M")
    start = time.mktime(t)
    t = time.strptime(end_, "%d %B %Y, %H:%M")
    end = time.mktime(t)
    ti = (start, end)
    return (r_type, ti)


#######################################################################################################################
#######################################################################################################################
def check(a):
	start = a[1][0]
	end = a[1][1]
	sport_type = a[0]
	sport_equipments = sports[sport_unique_id[sport_type]]
	availablity = []

	for equipment in sport_equipments.keys():
		count = sport_equipments[equipment]

		for slot in equipment_slot[equipment]:
			if ((start <= slot[0][0] < end) or (start < slot[0][1] <= end)):
				if (count > slot[1]):
					count = slot[1]

		availablity.append(count)

	return availablity


#######################################################################################################################
#######################################################################################################################
def orderc(a, availablity):
	sport_type = a[0]
	sport_equipments = list(sports[sport_unique_id[sport_type]].keys())
	order = [0]*len(sport_equipments)
	for i in range(len(order)):
		if availablity[i] != 0:
			root = tk.Tk()
			root.geometry(f'{400}x{170}')
			root.title("Order")
			limit = availablity[i]
			counter = tk.IntVar()

			def onClickp(event=None):
			    if counter.get()<limit:
			    	counter.set(counter.get() + 1)
                    
			def onClickn(event=None):
				if counter.get()>0:
					counter.set(counter.get() - 1)

			def Next():
				order[i] = counter.get()
				# print(var)
				root.destroy()

			def Cancel():
				order[i] = -1
				root.destroy()

			tk.Label(root, text=sport_equipments[i]).pack(pady= 10)
			tk.Button(root, text="+", command=onClickp).pack()
			tk.Label(root, textvariable=counter).pack()
			tk.Button(root, text="-", command=onClickn).pack(pady = 10)

			Nextbt = tk.Button(root, text='Next', command=Next)
			Nextbt.pack(side='right', fill='x', expand=True)

			Cancelbt = tk.Button(root, text='Cancel', command=Cancel)
			Cancelbt.pack(side='left', fill='x', expand=True)
			root.mainloop()

	return order


#######################################################################################################################
#######################################################################################################################
def authorize(name, order, a):
    global var
    sport_type = a[0]
    sport_equipments = list(sports[sport_unique_id[sport_type]].keys())

    def yes():
        global var
        var = 1
        root.destroy()

    def no():
        global var
        var = 0
        root.destroy()

    root = tk.Tk()
    root.geometry(f'{400}x{200}')
    root.winfo_toplevel().title("Authorise")

    sec1 = time.localtime(a[1][0])
    start = time.strftime("%d %B %Y, %H:%M", sec1)
    sec2 = time.localtime(a[1][1])
    end = time.strftime("%d %B %Y, %H:%M", sec2)

    string =""
    for i in range(len(order)):
        if(order[i] != 0):
            string+= sport_equipments[i] + ": "+ str(order[i]) + "\n" 

    st = name+"\n"+a[0]+"\nFrom: "+start + "\nTo: "+end+"\n\n"+string+"\nApprove ?\n"
    mainLabel = tk.Label(root, text=st)
    mainLabel.pack()

    yesbt = tk.Button(root, text='Yes', command=yes)
    yesbt.pack(side='left', fill='x', expand=True)

    nobt = tk.Button(root, text='No', command=no)
    nobt.pack(side='right', fill='x', expand=True)
    root.mainloop()


#######################################################################################################################
#######################################################################################################################
def update_slots(name, a, order, availablity):
    global equipment_slot


    start = a[1][0]
    end = a[1][1]
    sport_type = a[0]
    sport_equipments = list(sports[sport_unique_id[sport_type]].keys())
    # print(order)
    # print(availablity)
    for i in range(len(order)):
    	start = a[1][0]
    	end = a[1][1]
    	if order[i] != 0:
    		slot = [a[1], name, order[i]]
    		display_slot[sport_equipments[i]].append(slot)

    		time_slot = []
    		for j in equipment_slot[sport_equipments[i]]:
    			time_slot.append(j[0])

    		idx = 0
    		# print(i)
    		new_available = availablity[i] - order[i]
    		while start < end:
    			time = [start, start+slot_duration]
    			slot = [time, new_available]
    			if time in time_slot[idx:]:
    				# print("Hello")
    				idx = time_slot.index(time)
    				# print(idx)
    				equipment_slot[sport_equipments[i]][idx] = slot
    			else:
    				equipment_slot[sport_equipments[i]] = equipment_slot[sport_equipments[i]][:idx] + [slot] + equipment_slot[sport_equipments[i]][idx:]

    			start += slot_duration
    			idx+=1
	    		

#######################################################################################################################
#######################################################################################################################
def printf():
    for i in range(len(sports)):
        sport_type = list(sport_unique_id.keys())[list(sport_unique_id.values()).index(i)]
        print('****  '+sport_type+'  ****')
        for equipment in sports[i].keys():
        # for room in rooms[index].keys():
            print(equipment, end=":")
            no_entries = len(display_slot[equipment])
            if no_entries != 0:
                print()
                for data in display_slot[equipment]:
                	sec1 = time.localtime(data[0][0])
                	start = time.strftime("%d %B %Y, %H:%M", sec1)
                	sec2 = time.localtime(data[0][1])
                	end = time.strftime("%d %B %Y, %H:%M", sec2)
                	print("From "+start+" to "+end+" by "+ data[1])
                print()
            else:
            	print(" Empty")
            	print()
        print()
    pprint.pprint(equipment_slot)
    print()
    pprint.pprint(display_slot)


#######################################################################################################################
#######################################################################################################################
sports = []
sport_unique_id = {}
equipment_unique_id ={}
equipment_slot ={}
display_slot = {}
slot_duration = 60 * 30
availablity = []

#Not required for you.
initialize()

#Load from Google Sheets
load_total_quantities()
no_requests = int(input("\nNo of requests?\n"))
for _ in range(no_requests):
	flag_array = []
	
	var = 0
	name = input("\nEnter your name:\n")
	print()	
	a = entry()
	availabity = check(a)
	order = orderc(a, availabity)
	print("Message for User:")
	temp = availabity
	exist = -1 in order
	if exist:
		print("Order was cancelled.\n")
		printf()
		continue
	authorize(name, order, a)
	# print("Hello")
	# print(availabity)
	if var !=0:
		print("The Order has been successfully placed.\n")
		# print(temp)
		update_slots(name, a, order, temp)
	else:
		print("The Order was not authorized.\n")
        
	printf()
	print("\n")

    

