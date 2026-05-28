#!/usr/bin/env python3
"""
Airline Data Import Script
Bulk imports airline data from CSV to database.

Usage:
    python3 import_airlines.py

The script:
1. Updates airlines table with basic info (fleet, destinations, callsign, logo, website, alliance)
2. Inserts key personnel into airline_key_personnel table
3. Parses and inserts destination data into airline_destinations table

Data source: Airlines_List_Enhanced_gpt.csv
"""

import csv
import re
import paramiko

REMOTE_HOST = '43.134.34.14'
REMOTE_USER = 'ubuntu'
REMOTE_KEY = '/workspace/id_ed25519'
CSV_FILE = '/workspace/Airlines_List_Enhanced_gpt.csv'

def connect_ssh():
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(REMOTE_HOST, username=REMOTE_USER, key_filename=REMOTE_KEY, port=22, timeout=120)
    return ssh

def run_mysql(ssh, query):
    escaped = query.replace("'", "\\'")
    stdin, stdout, stderr = ssh.exec_command(f"mysql -u root -prootpassword anggani_data -e \"{escaped}\" 2>/dev/null")
    return stdout.read().decode(), stderr.read().decode()

def parse_destinations(dest_str, name='', iata='', icao=''):
    """Parse destination string into SQL INSERT statements"""
    sql_lines = []
    if not dest_str or not dest_str.strip():
        return sql_lines
    
    for part in dest_str.split(';'):
        part = part.strip()
        if not part:
            continue
        
        # Extract airport codes
        codes_match = re.search(r'\(([A-Z]{3,4})\)', part)
        iata_code = codes_match.group(1) if codes_match else ''
        
        # Determine status
        status = 'Active'
        if 'Terminated' in part: status = 'Terminated'
        elif 'Seasonal charter' in part: status = 'Seasonal charter'
        elif 'Seasonal' in part: status = 'Seasonal'
        elif 'Focus city' in part: status = 'Focus city'
        elif 'Hub' in part: status = 'Hub'
        elif 'Begins' in part: status = 'Planned'
        elif 'Closed' in part: status = 'Closed'
        
        # Extract country, city, airport name
        country_match = re.match(r'^([A-Za-z\s]+):', part)
        country = country_match.group(1).strip() if country_match else ''
        
        if country:
            rest = part[len(country)+1:].strip()
        else:
            rest = part
        
        city_match = re.match(r'^([^(—]+)', rest)
        city = city_match.group(1).strip().rstrip(',')if city_match else ''
        
        airport_match = re.search(r'—\s*(.+?)(?:—|$)', part)
        airport_name = airport_match.group(1).strip() if airport_match else ''
        
        hub = 'Hub' if status == 'Hub' else ('Focus city' if status == 'Focus city' else '')
        
        # Escape quotes
        city = city.replace("'", "''")
        country = country.replace("'", "''")
        airport_name = airport_name.replace("'", "''")
        
        if iata_code:
            sql_lines.append(
                f"INSERT INTO airline_destinations "
                f"(country_code, airline_name, airline_iata, airline_icao, city, country, airport_name, iata_code, status, hub, record_status) "
                f"VALUES ('', '{name}', '{iata}', '{icao}', '{city}', '{country}', '{airport_name}', '{iata_code}', '{status}', '{hub}', 'active');"
            )
    
    return sql_lines

def parse_key_personnel(key_people, iata='', icao=''):
    """Parse key personnel string into SQL INSERT statements"""
    sql_lines = []
    if not key_people or not key_people.strip():
        return sql_lines
    
    for person in key_people.split(';'):
        person = person.strip()
        if not person:
            continue
        
        match = re.match(r'^(.+?)\s*\((.+?)\)$', person)
        if match:
            person_name = match.group(1).strip().replace("'", "''")
            person_title = match.group(2).strip().replace("'", "''")
            
            title_lower = person_title.lower()
            if 'ceo' in title_lower: category = 'CEO'
            elif 'chairman' in title_lower: category = 'Chairman'
            elif 'president' in title_lower: category = 'President'
            elif 'vp' in title_lower: category = 'VP'
            else: category = 'Executive'
            
            sql_lines.append(
                f"INSERT INTO airline_key_personnel "
                f"(country_code, iata_code, icao_code, person_name, title, category) "
                f"VALUES ('', '{iata}', '{icao}', '{person_name}', '{person_title}', '{category}');"
            )
    
    return sql_lines

def generate_airline_updates():
    """Generate UPDATE statements for airlines table"""
    with open(CSV_FILE, 'r') as f:
        rows = list(csv.DictReader(f))
    
    sql_lines = []
    for row in rows:
        iata = row.get('IATA Code', '').strip()
        icao = row.get('ICAO Code', '').strip()
        fleet = row.get('Fleet Size', '').strip()
        dest_count = row.get('Destinations', '').strip()
        callsign = row.get('Callsign', '').strip()
        logo = row.get('Logo URL', '').strip()
        wiki = row.get('Wikipedia URL', '').strip()
        website = row.get('Website', '').strip().replace(' ', '')
        alliance = row.get('Alliance', '').strip()
        employees = row.get('Employees', '').strip()
        
        if not (iata or icao):
            continue
        
        updates = []
        if fleet and fleet.isdigit(): updates.append(f"fleet_size = {fleet}")
        if dest_count and dest_count.isdigit(): updates.append(f"destinations_count = {dest_count}")
        if callsign: updates.append(f"callsign = '{callsign}'")
        if logo: updates.append(f"logo_url = '{logo}'")
        if wiki: updates.append(f"wikipedia_url = '{wiki}'")
        if website: updates.append(f"website_url = '{website}'")
        if alliance: updates.append(f"alliance = '{alliance}'")
        if employees: updates.append(f"ceo_accountable_manager = '{employees[:200]}'")
        
        if updates:
            where = f"iata_code = '{iata}'" if iata else f"icao_code = '{icao}'"
            sql_lines.append(f"UPDATE airlines SET {', '.join(updates)} WHERE {where};")
    
    return sql_lines

def generate_personnel_inserts():
    """Generate INSERT statements for airline_key_personnel"""
    with open(CSV_FILE, 'r') as f:
        rows = list(csv.DictReader(f))
    
    sql_lines = []
    for row in rows:
        name = row.get('Name', '').strip()
        iata = row.get('IATA Code', '').strip()
        icao = row.get('ICAO Code', '').strip()
        key_people = row.get('Key people', '').strip()
        
        sql_lines.extend(parse_key_personnel(key_people, iata, icao))
    
    return sql_lines

def generate_destination_inserts():
    """Generate INSERT statements for airline_destinations"""
    with open(CSV_FILE, 'r') as f:
        rows = list(csv.DictReader(f))
    
    sql_lines = []
    for row in rows:
        name = row.get('Name', '').strip()
        iata = row.get('IATA Code', '').strip()
        icao = row.get('ICAO Code', '').strip()
        dest_str = row.get('Destinations - actual names and airport/city code', '').strip()
        
        sql_lines.extend(parse_destinations(dest_str, name, iata, icao))
    
    return sql_lines

def main():
    print("Airline Data Import Script")
    print("=" * 50)
    
    # Generate SQL files
    print("\n1. Generating airline UPDATE statements...")
    update_sql = generate_airline_updates()
    print(f"   Generated {len(update_sql)} UPDATE statements")
    
    print("\n2. Generating personnel INSERT statements...")  
    personnel_sql = generate_personnel_inserts()
    print(f"   Generated {len(personnel_sql)} INSERT statements")
    
    print("\n3. Generating destination INSERT statements...")
    dest_sql = generate_destination_inserts()
    print(f"   Generated {len(dest_sql)} INSERT statements")
    
    # Save SQL files locally
    with open('/tmp/airline_updates.sql', 'w') as f:
        f.write('\n'.join(update_sql))
    
    with open('/tmp/personnel.sql', 'w') as f:
        f.write('\n'.join(personnel_sql))
    
    with open('/tmp/destinations.sql', 'w') as f:
        f.write('\n'.join(dest_sql))
    
    print("\n4. SQL files saved. Upload and execute on server:")
    print("   - /tmp/airline_updates.sql")
    print("   - /tmp/personnel.sql")
    print("   - /tmp/destinations.sql")

if __name__ == '__main__':
    main()