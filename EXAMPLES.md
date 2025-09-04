# 📚 Rust Package Manager Usage Examples

## Basic Operations

### Running the program
```bash
cargo run
```

### Getting help
```
rpm> help
```

## Working with Packages

### Viewing available packages
```
rpm> available
```

Output:
```
Available packages:
Name                 Version         Description
------------------------------------------------------------
apache               2.4.57          Apache HTTP Server
chrome               119.0.6045      Google Chrome browser
curl                 8.4.0           Command line tool for transferring data
docker               24.0.7          Container platform
emacs                29.1            GNU Emacs text editor
firefox              118.0.1         Mozilla Firefox web browser
...
```

### Installing packages

#### Install with default version (0.1.0)
```
rpm> install firefox
✓ Package 'firefox' version 0.1.0 successfully installed
```

#### Install with specified version
```
rpm> install python 3.12.0
✓ Package 'python' version 3.12.0 successfully installed
```

#### Install custom package
```
rpm> install myapp 2.5.0
✓ Package 'myapp' version 2.5.0 successfully installed
```

### Viewing installed packages
```
rpm> list
```

Output:
```
Installed packages:
Name                 Version         Description
------------------------------------------------------------
firefox              0.1.0           Mozilla Firefox web browser
myapp                2.5.0           Custom package
python               3.12.0          Python programming language
```

### Removing packages
```
rpm> remove firefox
✓ Package 'firefox' version 0.1.0 successfully removed
```

## Package Search

### Search by name
```
rpm> search python
```

Output:
```
Found packages for query 'python':
Name                 Version         Description
------------------------------------------------------------
python               3.11.6          Python programming language [INSTALLED]
```

### Search by description
```
rpm> search browser
```

Output:
```
Found packages for query 'browser':
Name                 Version         Description
------------------------------------------------------------
chrome               119.0.6045      Google Chrome browser
firefox              118.0.1         Mozilla Firefox web browser
```

### Search by partial match
```
rpm> search data
```

Output:
```
Found packages for query 'data':
Name                 Version         Description
------------------------------------------------------------
curl                 8.4.0           Command line tool for transferring data
mongodb              7.0.2           Document database
mysql                8.0.35          MySQL database server
postgresql           16.0            PostgreSQL database
redis                7.2.3           In-memory data structure store
```

## Usage Scenarios

### Scenario 1: Setting up development environment
```
rpm> install git 2.42.0
rpm> install vscode 1.84.2
rpm> install nodejs 20.9.0
rpm> install python 3.11.6
rpm> list
```

### Scenario 2: Installing web server
```
rpm> install nginx 1.24.0
rpm> install mysql 8.0.35
rpm> install redis 7.2.3
rpm> available
```

### Scenario 3: Finding and installing editors
```
rpm> search editor
rpm> install vim
rpm> install emacs
rpm> list
```

### Scenario 4: System cleanup
```
rpm> list
rpm> remove vim
rpm> remove emacs
rpm> list
```

## Error Handling

### Attempting to install already installed package
```
rpm> install python
rpm> install python
❌ Error: Package 'python' is already installed
```

### Attempting to remove non-existent package
```
rpm> remove nonexistent
❌ Error: Package 'nonexistent' not found among installed packages
```

### Invalid command
```
rpm> invalidcommand
❌ Unknown command: 'invalidcommand'
Type 'help' for help
```

### Missing arguments
```
rpm> install
❌ Error: please specify package name

rpm> remove
❌ Error: please specify package name

rpm> search
❌ Error: please specify search query
```

## Automation

### Using with pipe
```bash
printf "install firefox\ninstall python 3.12.0\nlist\nexit\n" | cargo run
```

### Creating command script
```bash
cat << 'EOF' > commands.txt
available
install docker
install nginx
install mysql
list
search database
exit
EOF

cargo run < commands.txt
```

## Data State

### packages.json file
After installing several packages, the `packages.json` file will contain:

```json
{
  "installed": {
    "python": {
      "name": "python",
      "version": "3.12.0",
      "description": "Python programming language"
    },
    "docker": {
      "name": "docker", 
      "version": "0.1.0",
      "description": "Container platform"
    }
  },
  "available": {
    // ... all available packages
  }
}
```

### Data persistence
- Data is automatically saved after each install/remove operation
- When restarting the program, state is restored from file
- If file is missing, a new one is created with empty installed packages list

## Usage Tips

1. **Use search** to find needed packages before installation
2. **Specify versions** for precise version control of packages
3. **Regularly check** the list of installed packages with `list` command
4. **Create scripts** to automate installation of package sets
5. **Make backups** of `packages.json` file to preserve state