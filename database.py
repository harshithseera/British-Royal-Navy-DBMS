import pymysql
import subprocess as sp

def create_table(con, query, table_name):
    try:
        with con.cursor() as cursor:
            cursor.execute(query)
            con.commit()
    except pymysql.MySQLError as e:
        print(f"Error creating table {table_name}: {e}")

def create_all_tables(con):
    tables = {
        "LOCATION": """
            CREATE TABLE IF NOT EXISTS LOCATION (
                Coordinates VARCHAR(50) PRIMARY KEY,
                Location_Name VARCHAR(100)
            );
        """,
        "SHIP": """
            CREATE TABLE IF NOT EXISTS SHIP (
                Ship_ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(100),
                Ship_Type VARCHAR(50),
                Tonnage INT,
                Origin_Year INT,
                Origin_Shipyard VARCHAR(100),
                Gun_Count INT,
                Coordinates VARCHAR(50),
                Last_Port_Of_Call VARCHAR(100),
                Last_Date_Of_Call DATE,
                FOREIGN KEY (Coordinates) REFERENCES LOCATION(Coordinates)
            );
        """,
        "OFFICER": """
            CREATE TABLE IF NOT EXISTS OFFICER (
                Officer_ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(100),
                Age INT,
                Rank_Index INT,
                Birthplace VARCHAR(100),
                Status VARCHAR(50)
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
                Station_ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(100),
                Coordinates VARCHAR(50),
                FOREIGN KEY (Coordinates) REFERENCES LOCATION(Coordinates)
            );
        """,
        "PORT": """
            CREATE TABLE IF NOT EXISTS PORT (
                Port_ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(100),
                Coordinates VARCHAR(50),
                Alignment VARCHAR(50),
                FOREIGN KEY (Coordinates) REFERENCES LOCATION(Coordinates)
            );
        """,
        "DISPATCH": """
            CREATE TABLE IF NOT EXISTS DISPATCH (
                Dispatch_ID INT AUTO_INCREMENT PRIMARY KEY,
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
                Enemy_ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(100),
                Nationality VARCHAR(50),
                Threat_Level INT,
                Last_Reported_By INT,
                Last_Sighted_At VARCHAR(50),
                Last_Sighting DATE,
                Current_Status VARCHAR(50),
                FOREIGN KEY (Last_Reported_By) REFERENCES SHIP(Ship_ID),
                FOREIGN KEY (Last_Sighted_At) REFERENCES LOCATION(Coordinates)
            );
        """,
        "FLEET": """
            CREATE TABLE IF NOT EXISTS FLEET (
                Fleet_ID INT AUTO_INCREMENT PRIMARY KEY,
                Station INT,
                Commander_in_Chief INT,
                FOREIGN KEY (Station) REFERENCES STATION(Station_ID),
                FOREIGN KEY (Commander_in_Chief) REFERENCES OFFICER(Officer_ID)
            );
        """,
        "SQUADRON": """
            CREATE TABLE IF NOT EXISTS SQUADRON (
                Squadron_ID INT AUTO_INCREMENT PRIMARY KEY,
                Fleet INT,
                Commander INT,
                Station INT,
                S_Status VARCHAR(50),
                FOREIGN KEY (Fleet) REFERENCES FLEET(Fleet_ID),
                FOREIGN KEY (Commander) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Station) REFERENCES STATION(Station_ID)
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
                Engagement_ID INT AUTO_INCREMENT PRIMARY KEY,
                Coordinates VARCHAR(50),
                Time DATETIME,
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
        """,
        "SHIPYARD_LOCATION": """
            CREATE TABLE IF NOT EXISTS SHIPYARD_LOCATION (
                ORIGIN_SHIPYARD VARCHAR(100),
                ORIGIN_CITY VARCHAR(100),
                PRIMARY KEY (ORIGIN_SHIPYARD)
            );
        """,
        "FLAG_OFFICER": """
            CREATE TABLE IF NOT EXISTS FLAG_OFFICER (
                Officer_ID INT PRIMARY KEY,
                Title VARCHAR(50),
                Squadron INT,
                Flagship INT,
                Predecessor_ID INT,
                FOREIGN KEY (Officer_ID) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Flagship) REFERENCES SHIP(Ship_ID),
                FOREIGN KEY (Predecessor_ID) REFERENCES OFFICER(Officer_ID),
                FOREIGN KEY (Squadron) REFERENCES SQUADRON(Squadron_ID)
            );
        """
    }

    for table_name, query in tables.items():
        create_table(con, query, table_name)