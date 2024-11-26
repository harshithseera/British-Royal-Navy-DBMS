import pymysql
import subprocess as sp

# Function to execute table creation
def execute_query(con, query, table_name):
    try:
        with con.cursor() as cursor:
            cursor.execute(query)
            con.commit()
            print(f"Table {table_name} created successfully!")
    except pymysql.MySQLError as e:
        print(f"Error creating table {table_name}: {e}")

# Function to create all tables
def create_all_tables(con):
    tables = {
        "SHIP": """
            CREATE TABLE IF NOT EXISTS SHIP (
                Ship_ID INT PRIMARY KEY,
                Ship_Type VARCHAR(50),
                Origin_Year INT,
                Origin_Shipyard VARCHAR(100),
                Gun_Count INT,
                Coordinates VARCHAR(50),
                Last_Port_Of_Call VARCHAR(100),
                Last_Date_Of_Call DATE
            );
        """,
        "OFFICER": """
            CREATE TABLE IF NOT EXISTS OFFICER (
                Officer_ID INT PRIMARY KEY,
                Name VARCHAR(100),
                Age INT,
                Rank_Index INT,
                Birthplace VARCHAR(100),
                Status VARCHAR(50)
            );
        """,
        "FLAG_OFFICER": """
            CREATE TABLE IF NOT EXISTS FLAG_OFFICER (
                Officer_ID INT PRIMARY KEY,
                Title VARCHAR(50),
                Squadron VARCHAR(50),
                Flagship INT,
                Predecessor_ID INT,
                FOREIGN KEY (Officer_ID) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Flagship) REFERENCES SHIP(Ship_ID),
                FOREIGN KEY (Predecessor_ID) REFERENCES OFFICER(Officer_ID)
            );
        """,
        "COMMISSIONED_OFFICER": """
            CREATE TABLE IF NOT EXISTS COMMISSIONED_OFFICER (
                Officer_ID INT PRIMARY KEY,
                Seniority INT,
                Ship INT,
                Position VARCHAR(50),
                FOREIGN KEY (Officer_ID) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Ship) REFERENCES SHIP(Ship_ID)
            );
        """,
        "WARRANT_OFFICER": """
            CREATE TABLE IF NOT EXISTS WARRANT_OFFICER (
                Officer_ID INT PRIMARY KEY,
                Ship INT,
                Role VARCHAR(50),
                Appointing_Agency VARCHAR(100),
                FOREIGN KEY (Officer_ID) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Ship) REFERENCES SHIP(Ship_ID)
            );
        """,
        "PETTY_OFFICER": """
            CREATE TABLE IF NOT EXISTS PETTY_OFFICER (
                Officer_ID INT PRIMARY KEY,
                Ship INT,
                Rating VARCHAR(50),
                FOREIGN KEY (Officer_ID) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Ship) REFERENCES SHIP(Ship_ID)
            );
        """,
        "STATION": """
            CREATE TABLE IF NOT EXISTS STATION (
                Station_ID INT PRIMARY KEY,
                Name VARCHAR(100),
                Coordinates VARCHAR(50)
            );
        """,
        "PORT": """
            CREATE TABLE IF NOT EXISTS PORT (
                Port_ID INT PRIMARY KEY,
                Name VARCHAR(100),
                Coordinates VARCHAR(50),
                Alignment VARCHAR(50)
            );
        """,
        "LOCATION": """
            CREATE TABLE IF NOT EXISTS LOCATION (
                Coordinates VARCHAR(50) PRIMARY KEY,
                Location_Name VARCHAR(100)
            );
        """,
        "DISPATCH": """
            CREATE TABLE IF NOT EXISTS DISPATCH (
                Dispatch_ID INT PRIMARY KEY,
                Date_Issued DATE,
                Issuing_Officer INT,
                Orders TEXT,
                Dispatch_Vessel INT,
                FOREIGN KEY (Issuing_Officer) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Dispatch_Vessel) REFERENCES SHIP(Ship_ID)
            );
        """,
        "ENEMY_SHIP": """
            CREATE TABLE IF NOT EXISTS ENEMY_SHIP (
                Enemy_ID INT PRIMARY KEY,
                Nationality VARCHAR(50),
                Threat_Level INT,
                Last_Reported_By INT,
                Last_Sighted_At VARCHAR(50),
                Last_Sighting DATE,
                Current_Status VARCHAR(50),
                FOREIGN KEY (Last_Reported_By) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Last_Sighted_At) REFERENCES LOCATION(Coordinates)
            );
        """,
        "SQUADRON": """
            CREATE TABLE IF NOT EXISTS SQUADRON (
                Squadron_ID INT PRIMARY KEY,
                Fleet INT,
                Commander INT,
                Station INT,
                S_Status VARCHAR(50),
                FOREIGN KEY (Fleet) REFERENCES FLEET(Fleet_ID),
                FOREIGN KEY (Commander) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Station) REFERENCES STATION(Station_ID)
            );
        """,
        "FLEET": """
            CREATE TABLE IF NOT EXISTS FLEET (
                Fleet_ID INT PRIMARY KEY,
                Station INT,
                Commander_in_Chief INT,
                FOREIGN KEY (Station) REFERENCES STATION(Station_ID),
                FOREIGN KEY (Commander_in_Chief) REFERENCES OFFICER(Officer_ID)
            );
        """,
        "REPORT": """
            CREATE TABLE IF NOT EXISTS REPORT (
                Dispatch_ID INT,
                Reporting_Officer INT,
                R_Status VARCHAR(50),
                Description TEXT,
                PRIMARY KEY (Dispatch_ID),
                FOREIGN KEY (Dispatch_ID) REFERENCES DISPATCH(Dispatch_ID),
                FOREIGN KEY (Reporting_Officer) REFERENCES OFFICER(Officer_ID)
            );
        """,
        "ENGAGEMENT": """
            CREATE TABLE IF NOT EXISTS ENGAGEMENT (
                Engagement_ID INT PRIMARY KEY,
                Coordinates VARCHAR(50),
                Time TIMESTAMP,
                Casualties INT,
                Outcome VARCHAR(50),
                FOREIGN KEY (Coordinates) REFERENCES LOCATION(Coordinates)
            );
        """,
        "CREW": """
            CREATE TABLE IF NOT EXISTS CREW (
                Ship_ID INT,
                Name VARCHAR(100),
                Age INT,
                Role VARCHAR(50),
                PRIMARY KEY (Ship_ID, Name),
                FOREIGN KEY (Ship_ID) REFERENCES SHIP(Ship_ID)
            );
        """,
        "SHIPS_RECEIVED": """
            CREATE TABLE IF NOT EXISTS SHIPS_RECEIVED (
                Dispatch_ID INT,
                Ship_ID INT,
                PRIMARY KEY (Dispatch_ID, Ship_ID),
                FOREIGN KEY (Dispatch_ID) REFERENCES DISPATCH(Dispatch_ID),
                FOREIGN KEY (Ship_ID) REFERENCES SHIP(Ship_ID)
            );
        """,
        "SHIPS_IN_SQUADRON": """
            CREATE TABLE IF NOT EXISTS SHIPS_IN_SQUADRON (
                Squadron_ID INT,
                Ship_ID INT,
                PRIMARY KEY (Squadron_ID, Ship_ID),
                FOREIGN KEY (Squadron_ID) REFERENCES SQUADRON(Squadron_ID),
                FOREIGN KEY (Ship_ID) REFERENCES SHIP(Ship_ID)
            );
        """,
        "SUPPLIES_AT_PORT": """
            CREATE TABLE IF NOT EXISTS SUPPLIES_AT_PORT (
                Port_ID INT,
                Supply VARCHAR(100),
                PRIMARY KEY (Port_ID, Supply),
                FOREIGN KEY (Port_ID) REFERENCES PORT(Port_ID)
            );
        """,
        "SHIPS_ENGAGED": """
            CREATE TABLE IF NOT EXISTS SHIPS_ENGAGED (
                Engagement_ID INT,
                Ship_ID INT,
                PRIMARY KEY (Engagement_ID, Ship_ID),
                FOREIGN KEY (Engagement_ID) REFERENCES ENGAGEMENT(Engagement_ID),
                FOREIGN KEY (Ship_ID) REFERENCES SHIP(Ship_ID)
            );
        """,
        "ENEMIES_ENGAGED": """
            CREATE TABLE IF NOT EXISTS ENEMIES_ENGAGED (
                Engagement_ID INT,
                Enemy_ID INT,
                PRIMARY KEY (Engagement_ID, Enemy_ID),
                FOREIGN KEY (Engagement_ID) REFERENCES ENGAGEMENT(Engagement_ID),
                FOREIGN KEY (Enemy_ID) REFERENCES ENEMY_SHIP(Enemy_ID)
            );
        """
    }

    for table_name, query in tables.items():
        execute_query(con, query, table_name)

# Main function
def main():
    try:
        # Connect to the database
        con = pymysql.connect(
            host='localhost',
            port=3306,
            user="root",
            password=input("Passwd: "),
            db='navy',
            cursorclass=pymysql.cursors.DictCursor
        )
        print("Connected to the database successfully!")

        while True:
            sp.call('clear', shell=True)
            print("==== British Royal Navy DBMS ====")
            print("1. Create All Tables")
            print("2. Exit")
            choice = input("Enter your choice: ")

            if choice == '1':
                create_all_tables(con)
                input("Tables created successfully! Press Enter to return to the menu...")
            elif choice == '2':
                print("Exiting...")
                break
            else:
                print("Invalid choice. Please try again.")
                input("Press Enter to continue...")

    except pymysql.MySQLError as e:
        print(f"Database connection failed: {e}")
    finally:
        if 'con' in locals():
            con.close()
            print("Database connection closed.")

# if __name__ == "__main__":
#     main()
