
import pymysql

# Manage connection to SQL db
def connect_db():

	pwd = input("Might we see some credentials?");

	return pymysql.connect(
		host = 'localhost',
		user = 'root',
		password = pwd,
		database = 'navy',
		cursorclass=pymysql.cursors.DictCursor
	)

def close_db(connection):
	connection.close()

# Function to execute a query
def execute_query(con:pymysql.Connection, query, values=None):
    try:
        with con.cursor() as cursor:
            if values:
                cursor.execute(query, values)
            else:
                cursor.execute(query)
            con.commit()
            print("Query executed successfully!")
    except pymysql.MySQLError as e:
        print(f"Error executing query: {e}")

# Function to insert data
def insert_data(con, table, data):
    columns = ', '.join(data.keys())
    placeholders = ', '.join(['%s'] * len(data))
    query = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"
    execute_query(con, query, tuple(data.values()))

# Function to delete data
def delete_data(con, table, condition_column, condition_value):
    query = f"DELETE FROM {table} WHERE {condition_column} = {condition_value}"
    execute_query(con, query)

# Function to update data
def update_data(con, table, updates, condition_column, condition_value):
    set_clause = ', '.join([f"{col} = %s" for col in updates.keys()])
    query = f"UPDATE {table} SET {set_clause} WHERE {condition_column} = %s"
    values = list(updates.values()) + [condition_value]
    execute_query(con, query, values)
    
def select_data(con, table, columns, condition=None):
	try:
		columns = ', '.join(columns)
		if condition:
			query = f"SELECT {columns} FROM {table} WHERE {condition}"
			with con.cursor() as cursor:
				cursor.execute(query, (condition,))
				result = cursor.fetchall()
				return result
		else:
			query = f"SELECT {columns} FROM {table}"
			with con.cursor() as cursor:
				cursor.execute(query)
				result = cursor.fetchall()
				return result
	except pymysql.MySQLError as e:
		print(f"Error executing query: {e}")
		return None
    
def get_last_inserted_id(con):
	query = "SELECT LAST_INSERT_ID()"
	with con.cursor() as cursor:
		cursor.execute(query)
		result = cursor.fetchone()
		return result[0]


# Addition queries

def add_ship(connection):
    ship_details = {}
    ship_details["Name"] = input("Enter ship name:\n")
    ship_details["Ship_Type"] = input("Enter ship type:\n")
    ship_details["Tonnage"] = input("Enter ship tonnage:\n")
    ship_details["Origin_Year"] = input("Enter origin year:\n")
    ship_details["Origin_Shipyard"] = input("Enter origin shipyard:\n")
    ship_details["Gun_Count"] = input("Enter gun count:\n")
    ship_details["Coordinates"] = input("Enter ship coordinates:\n")
    ship_details["Last_Port_Of_Call"] = input("Enter last port of call:\n")
    ship_details["Last_Date_Of_Call"] = input("Enter last date of call:\n")

    insert_data(connection, "SHIP", ship_details)

def add_officer(connection):
    officer_details = {}
    officer_details["Name"] = input("Enter officer name:\n")
    officer_details["Age"] = input("Enter officer age:\n")
    officer_details["Rank_Index"] = input("Enter officer rank index:\n")
    officer_details["Birthplace"] = input("Enter officer birthplace:\n")
    officer_details["Status"] = input("Enter officer status:\n")

    insert_data(connection, "OFFICER", officer_details)


def make_flag_officer(connection):
    add_officer(connection)
    
    officer_details = {}

    officer_details["Officer_ID"] = str(get_last_inserted_id(connection))

    officer_details["Title"] = input("Enter officer name:\n")
    officer_details["Squadron"] = input("Enter officer's squadron:\n")
    officer_details["Flagship_ID"] = input("Enter officer's flagship ID:\n")
    officer_details["Predecessor_ID"] = input("Enter officer's predecessor ID:\n")

    insert_data(connection, "FLAG_OFFICER", officer_details)
    print("Flag officer added successfully!")
    
def make_commissioned_officer(connection):
    add_officer(connection)
	
    officer_details = {}
    officer_details["Officer_ID"] = str(get_last_inserted_id(connection))

    officer_details["Seniority"] = input("Enter officer's seniority:\n")
    officer_details["Ship_ID"] = input("Enter officer's ship ID:\n")
    officer_details["Position"] = input("Enter officer's position:\n")

    insert_data(connection, "COMMISSIONED_OFFICER", officer_details)	
    print("Commissioned officer added successfully!")

def make_warrant_officer(connection):
    add_officer(connection)

    officer_details = {}
	
    officer_details["Officer_ID"] = str(get_last_inserted_id(connection))
    officer_details["Role"] = input("Enter officer's role:\n")
    officer_details["Appointing_Agency"] = input("Enter officer's appointing agency:\n")

    str(get_last_inserted_id(connection))

    insert_data(connection, "WARRANT_OFFICER", officer_details)
    print("Warrant officer added successfully!")

def make_petty_officer(connection):
    add_officer(connection)
	
    officer_details = {}
	
    officer_details["Officer_ID"] = str(get_last_inserted_id(connection))
    officer_details["Ship_ID"] = input("Enter officer's ship ID:\n")
    officer_details["Rating"] = input("Enter officer's rating:\n")

    insert_data(connection, "PETTY_OFFICER", officer_details)
    print("Petty officer added successfully!")

def add_crew(connection):

    crew_details = {}
    crew_details["Name"] = input("Enter crew member name:\n")
    crew_details["Age"] = input("Enter crew member age:\n")
    crew_details["Role"] = input("Enter crew member role:\n")
    crew_details["Status"] = input("Enter crew member status:\n")

    insert_data(connection, "CREW", crew_details)


def add_dispatch(connection):
    dispatch_details = {}
	
    dispatch_details["Date_Issued"] = input("Enter date issued:\n")
    dispatch_details["Issuing_Officer"] = input("Enter issuing officer:\n")
    dispatch_details["Orders"] = input("Enter orders:\n")
    dispatch_details["Dispatch_Vessel"] = input("Enter dispatch vessel:\n")
	
    insert_data(connection, "DISPATCH", dispatch_details)
    dispatch_id = get_last_inserted_id(connection)

    receiving_ships = input("Enter receiving ship IDs (format: \"<ship_id1>, <ship_id2>, ...\"):\n")
    receiving_ships = receiving_ships.split(", ")
	
    for ship_id in receiving_ships:
        insert_data(connection, "SHIPS_RECEIVED", {"Dispatch_ID": dispatch_id, "Ship_ID": ship_id})
    print("Dispatch added successfully!")

def add_enemy_ship(connection):
    enemy_ship_details = {
        "Nationality": input("Enter nationality:\n"),
        "Threat_Level": input("Enter threat level:\n"),
        "Last_Reported_By": input("Enter last reported by (Officer ID):\n"),
        "Last_Sighted_At": input("Enter last sighted at (Coordinates):\n"),
        "Last_Sighting": input("Enter last sighting (Date):\n"),
        "Current_Status": input("Enter current status:\n")
    }
    insert_data(connection, "ENEMY_SHIP", enemy_ship_details)
    print("Enemy ship added successfully!\n")

def add_squadron(connection):
    squadron_details = {
        "Fleet": input("Enter fleet ID:\n"),
        "Commander": input("Enter commander ID:\n"),
        "Station": input("Enter station ID:\n"),
        "S_Status": input("Enter squadron status:\n")
    }
    insert_data(connection, "SQUADRON", squadron_details)
    squadron_id = get_last_inserted_id(connection)
    
    ships = input("Enter ships in squadron (format: \"<ship_id1>, <ship_id2>, ...\"):\n")
    ships = ships.split(", ")
    for ship_id in ships:
        insert_data(connection, "SHIPS_IN_SQUADRON", {"Squadron_ID": squadron_id, "Ship_ID": ship_id})

    print("Squadron added successfully!\n")

def add_fleet(connection):
    fleet_details = {
        "Station": input("Enter station ID:\n"),
        "Commander_in_Chief": input("Enter commander in chief ID:\n")
    }
    insert_data(connection, "FLEET", fleet_details)
    print("Fleet added successfully!\n")

def add_report(connection):
    report_details = {
        "Dispatch_ID": input("Enter dispatch ID:\n"),
        "Reporting_Officer": input("Enter reporting officer ID:\n"),
        "R_Status": input("Enter report status:\n"),
        "Description": input("Enter description:\n")
    }
    insert_data(connection, "REPORT", report_details)
    print("Report added successfully!\n")

def add_engagement(connection):
    engagement_details = {
        "Coordinates": input("Enter coordinates:\n"),
        "Time": input("Enter time (YYYY-MM-DD HH:MM:SS):\n"),
        "Casualties": input("Enter casualties:\n"),
        "Outcome": input("Enter outcome:\n")
    }
    insert_data(connection, "ENGAGEMENT", engagement_details)
    engagement_id = get_last_inserted_id(connection)

    ships = input("Enter British Royal Navy ships involved in the engagement (format: \"<ship_id1>, <ship_id2>, ...\"):\n")
    ships = ships.split(", ")
    for ship_id in ships:
        insert_data(connection, "SHIPS_ENGAGED", {"Engagement_ID": engagement_id, "Ship_ID": ship_id})

    ships = input("Enter enemy ships involved in the engagement (format: \"<enemy_ship_id1>, <enemy_ship_id2>, ...\"):\n")
    ships = ships.split(", ")
    for ship_id in ships:
        insert_data(connection, "ENEMY_SHIPS_ENGAGED", {"Engagement_ID": engagement_id, "Enemy_ID": ship_id})
    
    print("Engagement added successfully!\n")

def add_station(connection):
    station_details = {
        "Name": input("Enter station name:\n"),
        "Coordinates": input("Enter coordinates:\n")
    }
    insert_data(connection, "STATION", station_details)
    print("Station added successfully!\n")

def add_port(connection):
    port_details = {
        "Name": input("Enter port name:\n"),
        "Coordinates": input("Enter coordinates:\n"),
        "Alignment": input("Enter alignment:\n")
    }
    insert_data(connection, "PORT", port_details)
    port_id = get_last_inserted_id(connection)
    
    supplies = input("Enter supplies available at the port (format: \"<supply1>, <supply2>, ...\"):\n")
    supplies = supplies.split(", ")
    for supply in supplies:
        insert_data(connection, "SUPPLIES_AT_PORT", {"Port_ID": port_id, "Supply": supply})

    print("Port added successfully!\n")


# Modification/Update queries

def promote_officer(connection):
	officer_id = input("Enter officer ID to promote:\n")
	rank = input("Enter new rank:\n")
	update_data(connection, "OFFICER", {"Rank": rank}, "Officer_ID", officer_id)
	print("Officer promoted successfully!")

def update_last_enemy_sighting(connection):
	enemy_id = input("Enter enemy ship ID to update:\n")

	enemy_ship_details = input("Enter enemy ship details (format: \"<Nationality>, <Threat_Level>, <Last_Reported_By>, <Last_Sighted_At>, <Last_Sighting>, <Current_Status>\"):\n")
	update_data(connection, "ENEMY_SHIP", enemy_ship_details, "Enemy_ID", enemy_id)
	print("Enemy ship added successfully!")

def update_officer_status(connection):
	officer_id = input("Enter officer ID to update:\n")
	status = input("Enter new status:\n")
	update_data(connection, "OFFICER", {"Status": status}, "Officer_ID", officer_id)
	print("Officer status updated successfully!")

def update_ship_status(connection):
	ship_id = input("Enter ship ID to update:\n")
	status = input("Enter new status:\n")
	update_data(connection, "SHIP", {"Status": status}, "Ship_ID", ship_id)
	print("Ship status updated successfully!")

def update_port_alignment(connection):
	port_id = input("Enter port ID to update:\n")
	alignment = input("Enter new alignment:\n")
	update_data(connection, "PORT", {"Alignment": alignment}, "Port_ID", port_id)
	print("Port alignment updated successfully!")


# Selection queries

def get_ships_of_type(connection):
	ship_type = input("Enter ship type:\n")
	ships = select_data(connection, "SHIP", ["Ship_ID", "Name", "Tonnage", "Gun_Count", "Coordinates"], f"Ship_Type = {ship_type}")
	
	if (ships == None):
		print("No ships found")
		return
	
	print("Ships of type:\n")
	for ship in ships:
		print(f"Ship_ID: {ship['Ship_ID']}", f"Name: {ship['Name']}", f"Tonnage: {ship['Tonnage']}", f"Guns: {ship['Gun_Count']}", f"Coordinates: {ship['Coordinates']}")

def get_dispatches_between(connection):
	start_date = input("Enter start date (YYYY-MM-DD):\n")
	end_date = input("Enter end date (YYYY-MM-DD):\n")
	dispatches = select_data(connection, "DISPATCH", ["Dispatch_ID", "Date_Issued", "Orders"], f"Date_Issued BETWEEN {start_date} AND {end_date}")
	
	if (dispatches == None):
		print("No ships found")
		return

	print("Dispatches between dates:\n")
	for dispatch in dispatches:
		print(f"Dispatch ID: {dispatch['Dispatch_ID']}", f"Date Issued: {dispatch['Date_Issued']}", f"Description: {dispatch['Description']}")

def get_active_flag_officers(connection):
	flag_officers = select_data(connection, "FLAG_OFFICER AS f JOIN OFFICER AS o ON f.Officer_ID = o.Officer_ID", ['Name'], "Status = 'Active'")
	
	if (flag_officers == None):
		print("No flag officers found")
		return
	
	print("Active flag officers:\n")
	for officer in flag_officers:
		print(f"Name: {officer['Name']}")


# Projection queries

def get_ship_names_with_higher_gun_count(connection):
	gun_count = input("Enter gun count:\n")
	ships = select_data(connection, "SHIP", ["Ship_ID", "Name"], f"Gun_Count > {gun_count}")

	if (ships == None):
		print("No ships found")
		return

	print("Ships with higher gun count:\n")
	for ship in ships:
		print(f"Ship_ID: {ship['Ship_ID']}", f"Name: {ship['Name']}")

def threats_worse_than(connection):
	threat_level = input("Enter threat level:\n")
	ships = select_data(connection, "ENEMY_SHIP", ["Enemy_ID", "Name", "Current_Status"], f"Threat_Level > {threat_level}")

	if (ships == None):
		print("No ships found")
		return

	print("Worse threats:\n")
	for ship in ships:
		print(f"Enemy ID: {ship['Enemy_ID']}", f"Name: {ship['Name']}", f"Status: {ship['Current_Status']}")


# Aggregation queries

def get_biggest_threat(connection):
	ship = select_data(connection, "ENEMY_SHIP", ["Name", "Threat_Level"], "Threat_Level = (SELECT MAX(Threat_Level) FROM ENEMY_SHIP)")

	if (ship == None):
		print("Error executing query")
		return

	print("Biggest threat:\n")
	print(f"Name: {ship[0]['Name']}", f"Threat Level: {ship[0]['Threat_Level']}")

def get_total_gun_count(connection):
	squadron_id = input("Enter squadron ID:\n")
	gun_count = select_data(connection, "SHIP", ["SUM(Gun_Count)"], f"Ship_ID IN (SELECT Ship_ID FROM SHIPS_IN_SQUADRON WHERE Squadron_ID = {squadron_id})")

	if (gun_count == None):
		print("Error executing query")
		return

	print(f"Total gun count: {gun_count[0]['SUM(Gun_Count)']}")

def get_juniormost_commissioned_officer_on_ship(connection):
	ship_id = input("Enter ship ID:\n")
	officer = select_data(connection, "COMMISSIONED_OFFICER", ["Officer_ID", "Name", "MIN(Seniority)"], f"Ship_ID = {ship_id}")

	if (officer == None):
		print("Error executing query")
		return

	print("Juniormost commissioned officer:\n")
	print(f"Officer ID: {officer[0]['Officer_ID']}", f"Name: {officer[0]['Name']}", f"Seniority: {officer[0]['MIN(Seniority)']}")


# Search queries

def get_port_matching_name(connection):
	word = input("Enter word:\n")
	ports = select_data(connection, "PORT", ["Port_ID", "Name"], f"Name LIKE '%{word}%'")

	if (ports == None):
		print("No ports found")
		return

	print("Ports matching name:\n")
	for port in ports:
		print(f"Port ID: {port['Port_ID']}", f"Name: {port['Name']}")

def get_captain_of_ship(connection):
	ship_id = input("Enter ship ID:\n")
	captain = select_data(connection, "COMMISSIONED_OFFICER", ["Officer_ID", "Name"], f"Position = 'Captain' AND Ship_ID = {ship_id}")

	if (captain == None):
		print("No captain found")
		return

	print(f"Captain's Officer ID: {captain[0]['Officer_ID']}", f"Name: {captain[0]['Name']}")

def get_flag_officers_of_colour(connection):
	colour = input("Enter colour:\n")
	officers = select_data(connection, "FLAG_OFFICER", ["Officer_ID", "Name"], f"Colour = {colour}")

	if (officers == None):
		print("No flag officers found")
		return

	print("Flag officers of colour:\n")
	for officer in officers:
		print(f"Officer ID: {officer['Officer_ID']}", f"Name: {officer['Name']}")

def get_commissioned_officer_of_rank(connection):
	ship_id = input("Enter ship ID:\n")
	rank = input("Enter rank:\n")
	officer = select_data(connection, "COMMISSIONED_OFFICER", ["Officer_ID", "Name"], f"Position = {rank} AND Ship_ID = {ship_id}")

	if (officer == None):
		print("No commissioned officer found")
		return

	print(f"Officer ID: {officer[0]['Officer_ID']}", f"Name: {officer[0]['Name']}")


# Analysis queries

def get_num_reports_of_officer_with_status(connection):
	officer_id = input("Enter officer ID:\n")
	status = input("Enter status:\n")
	count = select_data(connection, "REPORT LEFT JOIN OFFICER ON Reporting_Officer = Officer_ID", ["COUNT(*)"], f"Reporting_Officer = {officer_id} AND R_Status = {status}")

	if (count == None):
		print("No reports found")
		return

	print(f"Number of reports: {count[0]['COUNT(*)']}")


# Deletion queries

def delete_obsolete_engagements(connection):
	engagements = select_data(connection, "ENGAGEMENT", ["Engagement_ID", "DATEDIFF(\"YEAR\", Time, CURRENT_TIMESTAMP) as Age"], "Age > 10")

	if (engagements == None):
		print("No obsolete engagements found")
		return

	for engagement in engagements:
		delete_data(connection, "SHIPS_ENGAGED", "Engagement_ID", engagement["Engagement_ID"])
		delete_data(connection, "ENEMY_SHIPS_ENGAGED", "Engagement_ID", engagement["Engagement_ID"])
		delete_data(connection, "ENGAGEMENT", "Engagement_ID", engagement["Engagement_ID"])
		
	print("Obsolete engagements deleted successfully!")


from database import create_all_tables

def main():

	print("Greetings, welcome to the Naval Archives.")
	connection = connect_db();

	create_all_tables(connection)

	print("Type 'exit' to leave the archives")

	while True:
		user_input = input("Pray enter your wish:\n").strip().lower()
        
		if user_input == "add ship":
			add_ship(connection)
		elif user_input == "add flag officer":
			make_flag_officer(connection)
		elif user_input == "add commissioned officer":
			make_commissioned_officer(connection)
		elif user_input == "add warrant officer":
			make_warrant_officer(connection)
		elif user_input == "add petty officer":
			make_petty_officer(connection)
		elif user_input == "add dispatch":
			add_dispatch(connection)
		elif user_input == "add enemy ship":
			add_enemy_ship(connection)
		elif user_input == "add squadron":
			add_squadron(connection)
		elif user_input == "add fleet":
			add_fleet(connection)
		elif user_input == "add report":
			add_report(connection)
		elif user_input == "add engagement":
			add_engagement(connection)
		elif user_input == "add station":
			add_station(connection)
		elif user_input == "add port":
			add_port(connection)
		elif user_input == "promote officer":
			promote_officer(connection)
		elif user_input == "exit":
			break
		else:
			print("Unknown command. Please try again.")

	print("Good luck, and may the wind fill your sails!")
	close_db(connection)

if __name__ == "__main__":
	main()