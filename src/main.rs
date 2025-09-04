use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::fs;
use std::io::{self, Write};

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Package {
    name: String,
    version: String,
    description: String,
}

#[derive(Debug, Serialize, Deserialize)]
struct PackageDatabase {
    installed: HashMap<String, Package>,
    available: HashMap<String, Package>,
}

impl PackageDatabase {
    fn new() -> Self {
        let mut db = PackageDatabase {
            installed: HashMap::new(),
            available: HashMap::new(),
        };

        // Add test packages to available packages database
        db.populate_available_packages();
        db
    }

    fn populate_available_packages(&mut self) {
        let test_packages = vec![
            ("firefox", "118.0.1", "Mozilla Firefox web browser"),
            ("chrome", "119.0.6045", "Google Chrome browser"),
            ("vscode", "1.84.2", "Visual Studio Code editor"),
            ("git", "2.42.0", "Distributed version control system"),
            ("python", "3.11.6", "Python programming language"),
            ("nodejs", "20.9.0", "JavaScript runtime"),
            ("docker", "24.0.7", "Container platform"),
            ("vim", "9.0.2048", "Vi IMproved text editor"),
            ("emacs", "29.1", "GNU Emacs text editor"),
            ("gcc", "13.2.0", "GNU Compiler Collection"),
            ("rust", "1.73.0", "Rust programming language"),
            ("go", "1.21.4", "Go programming language"),
            ("java", "21.0.1", "OpenJDK Java runtime"),
            ("mysql", "8.0.35", "MySQL database server"),
            ("postgresql", "16.0", "PostgreSQL database"),
            ("nginx", "1.24.0", "HTTP and reverse proxy server"),
            ("apache", "2.4.57", "Apache HTTP Server"),
            ("redis", "7.2.3", "In-memory data structure store"),
            ("mongodb", "7.0.2", "Document database"),
            ("curl", "8.4.0", "Command line tool for transferring data"),
        ];

        for (name, version, description) in test_packages {
            self.available.insert(
                name.to_string(),
                Package {
                    name: name.to_string(),
                    version: version.to_string(),
                    description: description.to_string(),
                },
            );
        }
    }

    fn load_from_file() -> io::Result<Self> {
        match fs::read_to_string("packages.json") {
            Ok(content) => {
                let mut db: PackageDatabase = serde_json::from_str(&content)
                    .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;

                // If available packages is empty, populate it
                if db.available.is_empty() {
                    db.populate_available_packages();
                }
                Ok(db)
            }
            Err(_) => {
                let db = PackageDatabase::new();
                db.save_to_file()?;
                Ok(db)
            }
        }
    }

    fn save_to_file(&self) -> io::Result<()> {
        let json = serde_json::to_string_pretty(self)
            .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;
        fs::write("packages.json", json)
    }

    fn install_package(&mut self, name: &str, version: Option<&str>) -> Result<(), String> {
        if self.installed.contains_key(name) {
            return Err(format!("Package '{}' is already installed", name));
        }

        let package = match self.available.get(name) {
            Some(pkg) => {
                let version = version.unwrap_or("0.1.0");
                Package {
                    name: name.to_string(),
                    version: version.to_string(),
                    description: pkg.description.clone(),
                }
            }
            None => {
                let version = version.unwrap_or("0.1.0");
                Package {
                    name: name.to_string(),
                    version: version.to_string(),
                    description: "Custom package".to_string(),
                }
            }
        };

        self.installed.insert(name.to_string(), package);
        println!(
            "✓ Package '{}' version {} successfully installed",
            name,
            version.unwrap_or("0.1.0")
        );
        Ok(())
    }

    fn remove_package(&mut self, name: &str) -> Result<(), String> {
        match self.installed.remove(name) {
            Some(package) => {
                println!(
                    "✓ Package '{}' version {} successfully removed",
                    package.name, package.version
                );
                Ok(())
            }
            None => Err(format!(
                "Package '{}' not found among installed packages",
                name
            )),
        }
    }

    fn list_installed(&self) {
        if self.installed.is_empty() {
            println!("No installed packages");
            return;
        }

        println!("Installed packages:");
        println!("{:<20} {:<15} {}", "Name", "Version", "Description");
        println!("{:-<60}", "");

        let mut packages: Vec<_> = self.installed.values().collect();
        packages.sort_by(|a, b| a.name.cmp(&b.name));

        for package in packages {
            println!(
                "{:<20} {:<15} {}",
                package.name, package.version, package.description
            );
        }
    }

    fn list_available(&self) {
        println!("Available packages:");
        println!("{:<20} {:<15} {}", "Name", "Version", "Description");
        println!("{:-<60}", "");

        let mut packages: Vec<_> = self.available.values().collect();
        packages.sort_by(|a, b| a.name.cmp(&b.name));

        for package in packages {
            let status = if self.installed.contains_key(&package.name) {
                " [INSTALLED]"
            } else {
                ""
            };

            println!(
                "{:<20} {:<15} {}{}",
                package.name, package.version, package.description, status
            );
        }
    }

    fn search_packages(&self, query: &str) -> Vec<&Package> {
        let query_lower = query.to_lowercase();
        let mut results = Vec::new();

        // Search among available packages
        for package in self.available.values() {
            if package.name.to_lowercase().contains(&query_lower)
                || package.description.to_lowercase().contains(&query_lower)
            {
                results.push(package);
            }
        }

        // Search among installed packages
        for package in self.installed.values() {
            if (package.name.to_lowercase().contains(&query_lower)
                || package.description.to_lowercase().contains(&query_lower))
                && !results.iter().any(|p| p.name == package.name)
            {
                results.push(package);
            }
        }

        results.sort_by(|a, b| a.name.cmp(&b.name));
        results
    }
}

fn print_help() {
    println!("Simple Package Manager written in Rust");
    println!("Usage:");
    println!("  install <name> [version]     - Install package");
    println!("  remove <name>                - Remove package");
    println!("  list                         - Show installed packages");
    println!("  available                    - Show available packages");
    println!("  search <query>               - Search packages");
    println!("  help                         - Show this help");
    println!("  exit                         - Exit the program");
}

fn main() -> io::Result<()> {
    println!("🦀 Welcome to Rust Package Manager!");
    println!("Type 'help' for help\n");

    let mut db = PackageDatabase::load_from_file()?;

    loop {
        print!("rpm> ");
        io::stdout().flush()?;

        let mut input = String::new();
        io::stdin().read_line(&mut input)?;

        let input = input.trim();
        if input.is_empty() {
            continue;
        }

        let parts: Vec<&str> = input.split_whitespace().collect();
        let command = parts[0];

        match command {
            "install" => {
                if parts.len() < 2 {
                    println!("❌ Error: please specify package name");
                    continue;
                }
                let package_name = parts[1];
                let version = parts.get(2).copied();

                match db.install_package(package_name, version) {
                    Ok(_) => {
                        if let Err(e) = db.save_to_file() {
                            println!("⚠️ Warning: failed to save changes: {}", e);
                        }
                    }
                    Err(e) => println!("❌ Error: {}", e),
                }
            }
            "remove" => {
                if parts.len() < 2 {
                    println!("❌ Error: please specify package name");
                    continue;
                }
                let package_name = parts[1];

                match db.remove_package(package_name) {
                    Ok(_) => {
                        if let Err(e) = db.save_to_file() {
                            println!("⚠️ Warning: failed to save changes: {}", e);
                        }
                    }
                    Err(e) => println!("❌ Error: {}", e),
                }
            }
            "list" => {
                db.list_installed();
            }
            "available" => {
                db.list_available();
            }
            "search" => {
                if parts.len() < 2 {
                    println!("❌ Error: please specify search query");
                    continue;
                }
                let query = parts[1..].join(" ");
                let results = db.search_packages(&query);

                if results.is_empty() {
                    println!("No packages found for query '{}'", query);
                } else {
                    println!("Found packages for query '{}':", query);
                    println!("{:<20} {:<15} {}", "Name", "Version", "Description");
                    println!("{:-<60}", "");

                    for package in results {
                        let status = if db.installed.contains_key(&package.name) {
                            " [INSTALLED]"
                        } else {
                            ""
                        };

                        println!(
                            "{:<20} {:<15} {}{}",
                            package.name, package.version, package.description, status
                        );
                    }
                }
            }
            "help" => {
                print_help();
            }
            "exit" => {
                println!("Goodbye! 👋");
                break;
            }
            _ => {
                println!("❌ Unknown command: '{}'", command);
                println!("Type 'help' for help");
            }
        }

        println!(); // Empty line for better readability
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_package_creation() {
        let package = Package {
            name: "test_package".to_string(),
            version: "1.0.0".to_string(),
            description: "Test package".to_string(),
        };

        assert_eq!(package.name, "test_package");
        assert_eq!(package.version, "1.0.0");
        assert_eq!(package.description, "Test package");
    }

    #[test]
    fn test_database_creation() {
        let db = PackageDatabase::new();
        assert!(db.installed.is_empty());
        assert!(!db.available.is_empty());
        assert!(db.available.contains_key("firefox"));
        assert!(db.available.contains_key("python"));
    }

    #[test]
    fn test_package_installation() {
        let mut db = PackageDatabase::new();

        // Test installing existing package
        let result = db.install_package("firefox", None);
        assert!(result.is_ok());
        assert!(db.installed.contains_key("firefox"));
        assert_eq!(db.installed.get("firefox").unwrap().version, "0.1.0");

        // Test installing with specified version
        let result = db.install_package("python", Some("3.9.0"));
        assert!(result.is_ok());
        assert_eq!(db.installed.get("python").unwrap().version, "3.9.0");

        // Test duplicate installation
        let result = db.install_package("firefox", None);
        assert!(result.is_err());
    }

    #[test]
    fn test_package_removal() {
        let mut db = PackageDatabase::new();

        // Install package
        db.install_package("firefox", None).unwrap();
        assert!(db.installed.contains_key("firefox"));

        // Remove package
        let result = db.remove_package("firefox");
        assert!(result.is_ok());
        assert!(!db.installed.contains_key("firefox"));

        // Try to remove non-existent package
        let result = db.remove_package("nonexistent");
        assert!(result.is_err());
    }

    #[test]
    fn test_package_search() {
        let mut db = PackageDatabase::new();
        db.install_package("python", Some("3.9.0")).unwrap();

        // Search by name
        let results = db.search_packages("python");
        assert!(!results.is_empty());
        assert!(results.iter().any(|p| p.name.contains("python")));

        // Search by description
        let results = db.search_packages("browser");
        assert!(!results.is_empty());
        assert!(results.iter().any(|p| p.description.contains("browser")));

        // Search for non-existent
        let results = db.search_packages("nonexistent_package_xyz");
        assert!(results.is_empty());
    }

    #[test]
    fn test_custom_package_installation() {
        let mut db = PackageDatabase::new();

        // Install custom package
        let result = db.install_package("my_custom_app", Some("2.0.0"));
        assert!(result.is_ok());

        let installed_package = db.installed.get("my_custom_app").unwrap();
        assert_eq!(installed_package.name, "my_custom_app");
        assert_eq!(installed_package.version, "2.0.0");
        assert_eq!(installed_package.description, "Custom package");
    }

    #[test]
    fn test_default_version_assignment() {
        let mut db = PackageDatabase::new();

        // Install without specifying version
        db.install_package("test_app", None).unwrap();

        let installed_package = db.installed.get("test_app").unwrap();
        assert_eq!(installed_package.version, "0.1.0");
    }
}
