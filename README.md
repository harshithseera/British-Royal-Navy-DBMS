# The British Royal Navy DB## Add Functions:## Add Functions:
### add ship : 
Asks the user to input details about a ship (name, type, tonnage, etc.) and inserts this data into the SHIP table.
### add officer : 
Asks the user to input details about an officer (name, age, rank, etc.) and inserts this data into the OFFICER table.
### add crew : 
Asks the user to input details about a crew member (name, age, role, etc.) and inserts this data into the CREW table.
### add dispatch : 
Asks the user to input details about a dispatch (date, officer, orders, etc.), inserts the data into the DISPATCH table, and links ships to the dispatch.
### add enemy ship : 
Asks the user to input details about an enemy ship (nationality, threat level, status, etc.) and inserts this data into the ENEMY SHIP table.
### add squadron : 
Asks the user to input details about a squadron (fleet ID, commander, etc.), inserts this data into the SQUADRON table, and links ships to the squadron.
### add fleet : 
Asks the user to input details about a fleet (station, commander), inserts this data into the FLEET table.
### add report : 
Asks the user to input details about a report (dispatch ID, officer, status, etc.) and inserts this data into the REPORT table.
### add engagement : 
Asks the user to input details about a naval engagement (coordinates, time, casualties, etc.), inserts data into the ENGAGEMENT table, and links ships involved.
### add station : 
Asks the user to input details about a station (name, coordinates), inserts this data into the STATION table.
### add port : 
Asks the user to input details about a port (name, coordinates, alignment), inserts this data into the PORT table, and links supplies to the port.
## Modification/Update Functions:
### promote officer : 
Asks the user to input an officer's ID and a new rank, then updates the officer's rank in the OFFICER table.
### update last enemy sighting : 
Asks the user to update the details of an enemy ship (nationality, threat level, etc.) and updates the record in the ENEMY SHIP table.
### update officer status : 
Asks the user to input an officer's ID and a new status, then updates the officer's status in the OFFICER table.
### update ship status : 
Asks the user to input a ship’s ID and a new status, then updates the ship’s status in the SHIP table.
### update port alignment : 
Asks the user to input a port’s ID and a new alignment, then updates the port's alignment in the PORT table.
## Selection Queries:
### get ships of type : 
Asks the user to input a ship type, retrieves and displays a list of ships matching that type from the SHIP table.
### get dispatches between : 
Asks the user to input a date range, retrieves and displays dispatches issued within that date range.
### get active flag officers : 
Retrieves and displays all active flag officers by joining the FLAG OFFICER and OFFICER tables.
Projection Queries:
### get ship names with higher gun count : 
Asks the user to input a gun count, retrieves and displays ships with a higher gun count than the input value.
### threats worse than : 
Asks the user to input a threat level, retrieves and displays enemy ships with a higher threat level than the input value.
## Aggregation Queries:
### get biggest threat : 
Retrieves and displays the enemy ship with the highest threat level.
### get total gun count : 
Asks the user to input a squadron ID and retrieves the total gun count of ships within that squadron.
### get juniormost commissioned officer on ship : 
Asks the user to input a ship ID and retrieves the commissioned officer with the lowest seniority on that ship.
