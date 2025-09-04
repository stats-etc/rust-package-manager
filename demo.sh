#!/bin/bash

echo "🦀 Демонстрация Rust Package Manager"
echo "===================================="
echo ""

echo "Запускаем пакетный менеджер с набором демонстрационных команд..."
echo ""

# Создаем файл с командами для демонстрации
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

echo "Выполняемые команды:"
echo "1. help - показать справку"
echo "2. available - показать доступные пакеты"
echo "3. install firefox - установить Firefox (версия по умолчанию 0.1.0)"
echo "4. install python 3.12.0 - установить Python с указанной версией"
echo "5. install custompackage - установить пользовательский пакет"
echo "6. list - показать установленные пакеты"
echo "7. search browser - поиск пакетов с 'browser'"
echo "8. search database - поиск пакетов с 'database'"
echo "9. remove firefox - удалить Firefox"
echo "10. list - показать обновленный список"
echo "11. search python - поиск пакетов с 'python'"
echo "12. exit - выход"
echo ""

echo "Нажмите Enter для начала демонстрации..."
read

# Запускаем программу с командами из файла
cargo run < demo_commands.txt

echo ""
echo "Демонстрация завершена!"
echo ""
echo "Содержимое файла packages.json после демонстрации:"
echo "================================================="
cat packages.json | head -20
echo "..."
echo ""

# Удаляем временный файл
rm demo_commands.txt

echo "Для интерактивного использования запустите: cargo run"
