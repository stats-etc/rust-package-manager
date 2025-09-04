# 🦀 Rust Package Manager (RPM)

A simple package manager similar to apt-get, written in Rust.

## Features

- ✅ Install and remove packages
- ✅ List installed packages
- ✅ Search packages by name and description
- ✅ Auto-assign version 0.1.0 if not specified
- ✅ Save data in JSON file
- ✅ 20 pre-installed test packages
- ✅ Interactive command-line interface

## Installation and Running

```bash
# Clone the project and navigate to directory
cd rust-package-manager

# Build the project
cargo build --release

# Run
cargo run
```

## Commands

### Basic commands:

- `install <name> [version]` - Install package
- `remove <name>` - Remove package  
- `list` - Show installed packages
- `available` - Show all available packages
- `search <query>` - Search packages by name or description
- `help` - Show help
- `exit` - Exit the program

### Usage examples:

```bash
# Install package with automatic version 0.1.0
rpm> install firefox

# Install package with specified version
rpm> install python 3.11.6

# Remove package
rpm> remove firefox

# Show installed packages
rpm> list

# Show all available packages
rpm> available

# Search by name
rpm> search python

# Search by description
rpm> search browser

# Exit
rpm> exit
```

## Pre-installed Test Packages

The system includes 20 popular programs for testing:

| Name | Version | Description |
|------|---------|-------------|
| firefox | 118.0.1 | Mozilla Firefox web browser |
| chrome | 119.0.6045 | Google Chrome browser |
| vscode | 1.84.2 | Visual Studio Code editor |
| git | 2.42.0 | Distributed version control system |
| python | 3.11.6 | Python programming language |
| nodejs | 20.9.0 | JavaScript runtime |
| docker | 24.0.7 | Container platform |
| vim | 9.0.2048 | Vi IMproved text editor |
| emacs | 29.1 | GNU Emacs text editor |
| gcc | 13.2.0 | GNU Compiler Collection |
| rust | 1.73.0 | Rust programming language |
| go | 1.21.4 | Go programming language |
| java | 21.0.1 | OpenJDK Java runtime |
| mysql | 8.0.35 | MySQL database server |
| postgresql | 16.0 | PostgreSQL database |
| nginx | 1.24.0 | HTTP and reverse proxy server |
| apache | 2.4.57 | Apache HTTP Server |
| redis | 7.2.3 | In-memory data structure store |
| mongodb | 7.0.2 | Document database |
| curl | 8.4.0 | Command line tool for transferring data |

## Data Structure

Packages are saved in `packages.json` file in format:

```json
{
  "installed": {
    "package_name": {
      "name": "package_name",
      "version": "1.0.0", 
      "description": "Package description"
    }
  },
  "available": {
    // ... all available packages
  }
}
```

## Architecture

The project consists of main components:

- `Package` - structure for representing a package
- `PackageDatabase` - database of installed and available packages
- Interactive command loop with user input processing
- Save/load state to/from JSON file

## Dependencies

- `serde` - for data structure serialization
- `serde_json` - for working with JSON format

## License

MIT License