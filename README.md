# AnganiData

AnganiData is a curated collection of aviation datasets and a management tool designed to support the **AnganiOS** project. It provides a simple web interface to view, import, and manage data for airports, airlines, and aircraft.

## Features

- **Airport Viewer**: Browse and search through global airport data with a modern, responsive UI.
- **Bulk Import**: Easily import large datasets from CSV files into a MySQL database.
- **Data Management**: Add, edit, or delete individual airport records through simple forms.
- **Cleaned Datasets**: Pre-split and standardized data for various countries and categories.

## Getting Started

### Prerequisites

- PHP 7.4+
- MySQL Server
- Web Server (Apache/Nginx/PHP built-in server)

### Database Setup

1. Configure your database credentials in [db.php](file:///c:/Users/user/Documents/Angani/angani-data/db.php).
2. The system will automatically create the `angani_data` database and the necessary tables (`airports`, `airlines`, `aircraft`) upon first run.

### Running the Application

You can use the PHP built-in server for local development:
```bash
php -S localhost:8000
```
Then visit `http://localhost:8000` in your browser.

## Usage Guide

### 1. View Airports
Navigate to the "Viewer" ([index.php](file:///c:/Users/user/Documents/Angani/angani-data/index.php)) to see all registered airports. You can use the search bar to filter by name, identifier, country, or code.

### 2. Bulk Import
To populate the database with global data:
1. Go to "Bulk Import" ([import.php](file:///c:/Users/user/Documents/Angani/angani-data/import.php)).
2. Select the type of data (Airports, Airlines, or Aircraft).
3. If applicable, select the country you wish to import data for.
4. Click "Start Import". The system will process the CSV files located in the `datasets/` directory.

### 3. Add/Edit Airports
- To add a new airport, click "Add Airport" ([form.php](file:///c:/Users/user/Documents/Angani/angani-data/form.php)) in the navigation bar.
- To edit an existing airport, click the "Edit" button next to the airport in the Viewer.

## Directory Structure

- `/datasets`: Curated CSV data structured by country and type.
- `/scripts`: Utility scripts for data splitting and cleaning.
- `index.php`: The main airport viewer.
- `form.php`: Form for adding/editing records.
- `import.php`: Logic for bulk importing data.
- `db.php`: Database connection and schema initialization.
- `style.css`: Modern styling for the interface.

## License

This project is licensed under the MIT License. Datasets retain their original licenses (Public Domain or ODbL).
