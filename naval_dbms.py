import pymysql
from datetime import date
import prettytable

def get_table(data):
    if not data:
        print("No data available.\n")
        return

    table = prettytable.PrettyTable(data[0].keys())
    table.add_rows([row.values() for row in data])
    return table.get_string()

# Manage connection to SQL db
def connect_db():

	#pwd = input("Might we see some credentials?\n");

	return pymysql.connect(
		host = 'localhost',
		user = 'root',
		password = 'helloThere@757',
		database = 'navy_db',
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
    update_str = ', '.join([f"{col} = {val}" for col, val in updates.items()])
    query = f"UPDATE {table} SET {update_str} WHERE {condition_column} = {condition_value}"
    execute_query(con, query)
    
def select_data(con, table, columns, condition=None):
    try:
        columns = ', '.join(columns)
        if condition:
            query = f"SELECT {columns} FROM {table} WHERE {condition}"
            with con.cursor() as cursor:
                cursor.execute(query)
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
    except Exception as e:
        print(f"Error executing query: {e}")
        return None
    
def get_last_inserted_id(con):
	query = "SELECT LAST_INSERT_ID()"
	with con.cursor() as cursor:
		cursor.execute(query)
		result = cursor.fetchone()
		return result["LAST_INSERT_ID()"]


# Addition queries

def add_ship(connection):
    ship_details = {
        "Name": input("Enter ship name:\n"),
        "Ship_Type": input("Enter ship type:\n"),
        "Tonnage" : input("Enter ship tonnage:\n"),
        "Origin_Year" : input("Enter origin year:\n"),
        "Origin_Shipyard" : input("Enter origin shipyard:\n"),
        "Gun_Count" : input("Enter gun count:\n"),
        "Coordinates" : input("Enter ship coordinates:\n"),
        "Last_Port_Of_Call" : input("Enter last port of call:\n"),
        "Last_Date_Of_Call" : input("Enter last date of call:\n")
    }

    insert_data(connection, "SHIP", ship_details)
    print("Ship added successfully!")

def add_officer(connection):
    officer_details = {
        "Name" : input("Enter officer name:\n"),
        "Age" : input("Enter officer age:\n"),
        "Rank_Index" : input("Enter officer rank index:\n"),
        "Birthplace" : input("Enter officer birthplace:\n"),
        "Status" : input("Enter officer status:\n")
    }

    insert_data(connection, "OFFICER", officer_details)


def make_flag_officer(connection, officer_id = None):
    if officer_id is None:
        add_officer(connection)
        officer_id = get_last_inserted_id(connection)
    
    officer_details = {
        "Officer_ID" : officer_id,
        "Title" : input("Enter officer name:\n"),
        "Squadron" : input("Enter officer's squadron:\n"),
        "Flagship" : input("Enter officer's flagship ID:\n"),
        "Predecessor_ID" : input("Enter officer's predecessor ID:\n")
    }

    insert_data(connection, "FLAG_OFFICER", officer_details)
    print("Flag officer added successfully!")
    
def make_commissioned_officer(connection, officer_id = None):
    if officer_id is None:
        add_officer(connection)
        officer_id = get_last_inserted_id(connection)
	
    officer_details = {
        "Officer_ID" : officer_id,
        "Seniority" : input("Enter officer's seniority:\n"),
        "Ship" : input("Enter officer's ship ID:\n"),
        "Position" : input("Enter officer's position:\n")
    }

    insert_data(connection, "COMMISSIONED_OFFICER", officer_details)	
    print("Commissioned officer added successfully!")

def make_warrant_officer(connection, officer_id = None):
    if officer_id is None:
        add_officer(connection)
        officer_id = get_last_inserted_id(connection)

    officer_details = {
        "Officer_ID" : officer_id,
        "Role" : input("Enter officer's role:\n"),
        "Appointing_Agency" : input("Enter officer's appointing agency:\n")
    }

    insert_data(connection, "WARRANT_OFFICER", officer_details)
    print("Warrant officer added successfully!")

def make_petty_officer(connection, officer_id = None):
    if officer_id is None:
        add_officer(connection)
	
    officer_details = {
        "Officer_ID" : str(get_last_inserted_id(connection)),
        "Ship_ID" : input("Enter officer's ship ID:\n"),
        "Rating" : input("Enter officer's rating:\n")
    }

    insert_data(connection, "PETTY_OFFICER", officer_details)
    print("Petty officer added successfully!")

def add_crew(connection):
    crew_details = {
        "Name" : input("Enter crew member name:\n"),
        "Age" : input("Enter crew member age:\n"),
        "Role" : input("Enter crew member role:\n"),
        "Status" : input("Enter crew member status:\n")
    }

    insert_data(connection, "CREW", crew_details)
    print("Crew member added successfully!")


def add_dispatch(connection):
    dispatch_details = {
        "Date_Issued" : input("Enter date issued:\n"),
        "Issuing_Officer" : input("Enter issuing officer:\n"),
        "Orders" : input("Enter orders:\n"),
        "Dispatch_Vessel" : input("Enter dispatch vessel:\n")
    }
	
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
    print("Enemy ship added successfully!")

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

    print("Squadron added successfully!")

def add_fleet(connection):
    fleet_details = {
        "Station": input("Enter station ID:\n"),
        "Commander_in_Chief": input("Enter commander in chief ID:\n")
    }
    insert_data(connection, "FLEET", fleet_details)
    print("Fleet added successfully!")

def file_report(connection):
    report_details = {
        "Dispatch_ID": input("Enter dispatch ID:\n"),
        "Reporting_Officer": input("Enter reporting officer ID:\n"),
        "R_Status": input("Enter report status:\n"),
        "Description": input("Enter description:\n")
    }
    insert_data(connection, "REPORT", report_details)
    print("Report added successfully!")

def add_engagement(connection):
    engagement_details = {
        "Coordinates": input("Enter coordinates:\n"),
        "Time": input("Enter time (YYYY-MM-DD HH:MM:SS):\n"),
        "Casualties": input("Enter casualties:\n"),
        "Outcome": input("Enter outcome:")
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
    
    print("Engagement added successfully!")

def add_station(connection):
    station_details = {
        "Name": input("Enter station name:\n"),
        "Coordinates": input("Enter coordinates:\n")
    }
    insert_data(connection, "STATION", station_details)
    print("Station added successfully!")

def add_port(connection):
    port_details = {
        "Name": input("Enter port name:\n"),
        "Coordinates": input("Enter coordinates:\n"),
        "Alignment": input("Enter alignment:\n")
    }
    insert_data(connection, "PORT", port_details)
    port_id = get_last_inserted_id(connection)
    
    supplies = input("Enter supplies available at the port:\n")
    insert_data(connection, "SUPPLIES_AT_PORT", {"Port_ID": port_id, "Supply": supplies})

    print("Port added successfully!")

# Modification/Update queries

def update_officer_class(connection):
    officer_id = input("Enter officer ID:\n")

    classes = ["FLAG_OFFICER", "COMMISSIONED_OFFICER", "WARRANT_OFFICER", "PETTY_OFFICER"]
    for officer_class in classes:
        is_class = select_data(connection, "OFFICER", ["Officer"], f"EXISTS (SELECT Officer_ID FROM {officer_class} WHERE Officer_ID = {officer_id})")
    
        if not is_class:
            continue

        print(f"Current Class: {officer_class}")
        new_class = input("Enter new class:\n")

        if new_class not in classes:
            print("Invalid class")
            return

        if new_class == "FLAG_OFFICER":
             make_flag_officer(connection, officer_id)
        elif new_class == "COMMISSIONED_OFFICER":
            make_commissioned_officer(connection, officer_id)
        elif new_class == "WARRANT_OFFICER":
            make_warrant_officer(connection, officer_id)
        else:
            make_petty_officer(connection, officer_id)

        delete_data(connection, officer_class, "Officer_ID", officer_id)

def update_last_enemy_sighting(connection):
    enemy_id = input("Enter enemy ship ID to update:\n")
    curr_details = select_data(connection, "ENEMY_SHIP", ["*"], f"Enemy_ID = {enemy_id}")
    
    print(f"Current details:")
    print(get_table(curr_details))

    cols = input("Enter columns to update (format: \"<column1>, <column2>, ...\"):\n").split(", ")
    new_details = {}
    for col in cols:
        val = input(f"Enter new value for {col}:\n")
        new_details[col] = val

    update_data(connection, "ENEMY_SHIP", new_details, "Enemy_ID", enemy_id)
    print("Enemy ship added successfully!")

def update_officer_status(connection):
    officer_id = input("Enter officer ID to update:\n")

    curr_details = select_data(connection, "OFFICER", ["Status"], f"Officer_ID = {officer_id}")
    print(f"Current status: {curr_details[0]['Status']}")

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

def update_ship_of_officer(connection):
    officer_id = input("Enter officer ID to update:\n")
    ship_id = input("Enter new ship ID:\n")
    position = input("Enter position in new ship:\n")
    update_data(connection, "COMMISSIONED_OFFICER", {"Ship": ship_id, "Position" : f"\"{position}\""}, "Officer_ID", officer_id)
    print("Officer's ship updated successfully!")

# Selection queries

def get_ships_by_type(connection):
	ship_type = input("Enter ship type:\n")
	ships = select_data(connection, "SHIP", ["*"], f"Ship_Type LIKE \"%{ship_type}%\"")
	
	if (ships == None):
		print("No ships found")
		return
	
	print(f"Ships of type {ship_type}:")
	print(get_table(ships))

def get_dispatches_between(connection):
	start_date = input("Enter start date (YYYY-MM-DD):\n")
	end_date = input("Enter end date (YYYY-MM-DD):\n")
	dispatches = select_data(connection, "DISPATCH", ["Dispatch_ID", "Date_Issued", "Orders"], f"Date_Issued BETWEEN {start_date} AND {end_date}")
	
	if (dispatches == None):
		print("No ships found")
		return

	print("Dispatches between dates:")
	print(get_table(dispatches))

def get_active_flag_officers(connection):
    flag_officers = select_data(connection, "OFFICER NATURAL JOIN FLAG_OFFICER", ['Name'], "Status = 'Active'")
	
    if (flag_officers == None):
        print("No flag officers found")
        return
	
    print("Active flag officers:")
    print(get_table(flag_officers))

# Projection queries

def get_ship_names_with_higher_gun_count(connection):
	gun_count = input("Enter gun count:\n")
	ships = select_data(connection, "SHIP", ["Ship_ID", "Name"], f"Gun_Count > {gun_count}")

	if (ships == None):
		print("No ships found")
		return

	print("Ships with higher gun count:")
	print(get_table(ships))

def threats_worse_than(connection):
	threat_level = input("Enter threat level:\n")
	ships = select_data(connection, "ENEMY_SHIP", ["Enemy_ID", "Name", "Current_Status"], f"Threat_Level > {threat_level}")

	if (ships == None):
		print("No ships found")
		return

	print("Worse threats:")
	print(get_table(ships))


# Aggregation queries

def get_biggest_threat(connection):
	ship = select_data(connection, "ENEMY_SHIP", ["*"], "Threat_Level = (SELECT MAX(Threat_Level) FROM ENEMY_SHIP)")

	if (ship == None):
		print("Error executing query")
		return

	print("Biggest threat:")
	print(get_table(ship))

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

	print("Juniormost commissioned officer:")
	print(get_table(officer))

# Search queries

def get_ship_by_name(connection):
    name = input("Enter ship name:\n")
    ship = select_data(connection, "SHIP", ["*"], f"Name = {name}")

    if (ship == None):
        print("No ships found")
        return

    print("Ship(s):")
    print(get_table(ship))

def get_officer_by_name(connection):
    name = input("Enter officer name:\n")
    officer = select_data(connection, "OFFICER", ["*"], f"Name = {name}")

    if (officer == None):
        print("No officers found")
        return

    print("Officer:")
    print(get_table(officer))

def get_port_with_supplies(connection):
    supply = input("Enter supply:\n")
    ports = select_data(connection, "PORT NATURAL JOIN SUPPLIES_AT_PORT", ["*"], f"Supply LIKE\"%{supply}%\"")

    if (ports == None):
        print("No ports found")
        return

    print(f"Ports with {supply}:")
    print(get_table(ports))

def get_port_matching_name(connection):
    word = input("Enter word:\n")
    ports = select_data(connection, "PORT", ["Port_ID", "Name"], f"Name LIKE '%{word}%'")

    if (ports == None):
        print("No ports found")
        return
    
    print("Ports matching name:")
    print(get_table(ports))

def get_captain_of_ship(connection):
	ship_id = input("Enter ship ID:\n")
     
	captain = select_data(connection, "OFFICER NATURAL JOIN COMMISSIONED_OFFICER", ["o.Officer_ID as Officer_ID", "o.Name as Name"], f"c.Position = 'Captain' AND c.Ship = {ship_id}")

	if (captain == None):
		print("No captain found")
		return

	print(get_table(captain))

def get_flag_officers_of_title(connection):
	title = input("Enter title:\n")
	officers = select_data(connection, "OFFICER NATURAL JOIN FLAG_OFFICER", ["o.Officer_ID as Officer_ID", "o.Name as Name"], f"f.Title = {title}")

	if (officers == None):
		print("No flag officers found")
		return

	print("Flag officers of colour:")
	print(get_table(officers))

def get_commissioned_officer_of_rank(connection):
	ship_id = input("Enter ship ID:\n")
	rank = input("Enter rank:\n")
	officer = select_data(connection, "COMMISSIONED_OFFICER", ["Officer_ID", "Name"], f"Position = {rank} AND Ship_ID = {ship_id}")

	if (officer == None):
		print("No commissioned officer found")
		return

	print(get_table(officer))

# Analysis queries

def get_num_reports_of_officer_with_status(connection):
	officer_id = input("Enter officer ID:\n")
	status = input("Enter status:\n")
	count = select_data(connection, "REPORT LEFT JOIN OFFICER ON Reporting_Officer = Officer_ID", ["COUNT(*)"], f"Reporting_Officer = {officer_id} AND R_Status = \"{status}\"")

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

def show_all_of(connection, table):

    result = select_data(connection, table, ["*"])
    if table.endswith("OFFICER") and table != "OFFICER":
        result = select_data(connection, f"OFFICER NATURAL JOIN {table}", ["*"])

    if result == None:
        print("No data found")
        return
    
    print(get_table(result))
        
def print_command_list(command_map):
    print("Available commands:")

    table = prettytable.PrettyTable(["Command", "Description"])
    for i, command in enumerate(command_map.keys()):
        table.add_row([i + 1, command])

    print(table)

from database import create_all_tables
import subprocess as sp

def main():
    sp.call('clear', shell=True)
    connection = connect_db();
    create_all_tables(connection)

    print("Greetings, welcome to the Naval Archives.")

    command_map = {
        "add ship": lambda: add_ship(connection),
        "add flag officer": lambda: make_flag_officer(connection),
        "add commissioned officer": lambda: make_commissioned_officer(connection),
        "add warrant officer": lambda: make_warrant_officer(connection),
        "add petty officer": lambda: make_petty_officer(connection),
        "add dispatch": lambda: add_dispatch(connection),
        "add enemy ship": lambda: add_enemy_ship(connection),
        "add squadron": lambda: add_squadron(connection),
        "add fleet": lambda: add_fleet(connection),
        "add engagement": lambda: add_engagement(connection),
        "add station": lambda: add_station(connection),
        "add port": lambda: add_port(connection),
        "file a report": lambda: file_report(connection),
		"show all ships": lambda: show_all_of(connection, "SHIP"),
        "show all officers": lambda: show_all_of(connection, "OFFICER"),
        "show all crew": lambda: show_all_of(connection, "CREW"),
        "show all dispatches": lambda: show_all_of(connection, "DISPATCH"),
        "show all enemy ships": lambda: show_all_of(connection, "ENEMY_SHIP"),
        "show all squadrons": lambda: show_all_of(connection, "SQUADRON"),
        "show all fleets": lambda: show_all_of(connection, "FLEET"),
        "show all reports": lambda: show_all_of(connection, "REPORT"),
        "show all engagements": lambda: show_all_of(connection, "ENGAGEMENT"),
        "show all stations": lambda: show_all_of(connection, "STATION"),
        "show all ports": lambda: show_all_of(connection, "PORT"),
        "show all flag officers": lambda: show_all_of(connection, "FLAG_OFFICER"),
        "show all commissioned officers": lambda: show_all_of(connection, "COMMISSIONED_OFFICER"),
        "show all warrant officers": lambda: show_all_of(connection, "WARRANT_OFFICER"),
        "show all locations": lambda: show_all_of(connection, "LOCATION"),
        "update officer class": lambda: update_officer_class(connection),
        "update last enemy sighting": lambda: update_last_enemy_sighting(connection),
        "update officer status": lambda: update_officer_status(connection),
        "update ship status": lambda: update_ship_status(connection),
        "update port alignment": lambda: update_port_alignment(connection),
        "update ship of officer": lambda: update_ship_of_officer(connection),
        "get ships by type": lambda: get_ships_by_type(connection),
        "get ship by name": lambda: get_ship_by_name(connection),
        "get officer by name": lambda: get_officer_by_name(connection),
        "get port with supplies": lambda: get_port_with_supplies(connection),
        "get commissioned officer of rank": lambda: get_commissioned_officer_of_rank(connection),
		"get juniormost commissioned officer on ship": lambda: get_juniormost_commissioned_officer_on_ship(connection),
        "get port matching name": lambda: get_port_matching_name(connection),
        "get captain of ship": lambda: get_captain_of_ship(connection),
        "get flag officers of title": lambda: get_flag_officers_of_title(connection),
        "get dispatches between dates": lambda: get_dispatches_between(connection),
        "get active flag officers": lambda: get_active_flag_officers(connection),
        "get ship names with higher gun count": lambda: get_ship_names_with_higher_gun_count(connection),
        "get threats worse than": lambda: threats_worse_than(connection),
        "get num reports of officer with status": lambda: get_num_reports_of_officer_with_status(connection),
        "get total gun count in squadron": lambda: get_total_gun_count(connection),
        "get biggest threat": lambda: get_biggest_threat(connection)

    }

    print_command_list(command_map)
    print("Type 'help' to print command list, or 'exit' to leave the DB.\n")

    while True:
        user_input = input("Enter command number: ").strip().lower()
    
        if user_input == "exit": break
        if user_input == "help":
            print_command_list(command_map)
            continue
        if user_input == "" or user_input is None:
            continue

        command = command_map.get(list(command_map.keys())[int(user_input) - 1]) if user_input.isdigit() else command_map.get(user_input)
        
        if command:
            command()
        else:
            print("Unknown command! Please try again")

        print("\n")    

    print("Farewell, may the winds ever fill your sails!")
    close_db(connection)

if __name__ == "__main__":
	main()