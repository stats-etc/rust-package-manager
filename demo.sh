#!/bin/bash

echo "🦀 Rust Package Manager Demonstration"
echo "====================================="
echo ""

echo "Running package manager with a set of demonstration commands..."
echo ""

# Create file with demonstration commands
cat << 'EOF' > demo_commands.txt
help
available
install firefox
install python 3.12.0
install custompackage
list
search browser
search database
remove firefox
list
search python
exit
EOF

echo "Commands to be executed:"
echo "1. help - show help"
echo "2. available - show available packages"
echo "3. install firefox - install Firefox (default version 0.1.0)"
echo "4. install python 3.12.0 - install Python with specified version"
echo "5. install custompackage - install custom package"
echo "6. list - show installed packages"
echo "7. search browser - search packages with 'browser'"
echo "8. search database - search packages with 'database'"
echo "9. remove firefox - remove Firefox"
echo "10. list - show updated list"
echo "11. search python - search packages with 'python'"
echo "12. exit - exit"
echo ""

echo "Press Enter to start demonstration..."
read

# Run program with commands from file
cargo run < demo_commands.txt

echo ""
echo "Demonstration completed!"
echo ""
echo "Contents of packages.json file after demonstration:"
echo "==================================================="
cat packages.json | head -20
echo "..."
echo ""

# Remove temporary file
rm demo_commands.txt

echo "For interactive use, run: cargo run"
