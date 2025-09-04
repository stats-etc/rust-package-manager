# 🦀 Rust Package Manager (RPM)

Простейший аналог пакетного менеджера наподобие apt-get, написанный на Rust.

## Особенности

- ✅ Установка и удаление пакетов
- ✅ Список установленных пакетов
- ✅ Поиск пакетов по названию и описанию
- ✅ Автоматическое назначение версии 0.1.0 если не указана
- ✅ Сохранение данных в JSON файле
- ✅ 20 предустановленных тестовых пакетов
- ✅ Интерактивный интерфейс командной строки

## Установка и запуск

```bash
# Клонируйте проект и перейдите в директорию
cd rust-package-manager

# Соберите проект
cargo build --release

# Запустите
cargo run
```

## Команды

### Основные команды:

- `install <название> [версия]` - Установить пакет
- `remove <название>` - Удалить пакет  
- `list` - Показать установленные пакеты
- `available` - Показать все доступные пакеты
- `search <запрос>` - Поиск пакетов по названию или описанию
- `help` - Показать справку
- `exit` - Выйти из программы

### Примеры использования:

```bash
# Установить пакет с автоматической версией 0.1.0
rpm> install firefox

# Установить пакет с указанной версией
rpm> install python 3.11.6

# Удалить пакет
rpm> remove firefox

# Показать установленные пакеты
rpm> list

# Показать все доступные пакеты
rpm> available

# Поиск по названию
rpm> search python

# Поиск по описанию
rpm> search browser

# Выйти
rpm> exit
```

## Предустановленные тестовые пакеты

Система включает 20 популярных программ для тестирования:

| Название | Версия | Описание |
|----------|--------|----------|
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

## Структура данных

Пакеты сохраняются в файле `packages.json` в формате:

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
    // ... все доступные пакеты
  }
}
```

## Архитектура

Проект состоит из основных компонентов:

- `Package` - структура для представления пакета
- `PackageDatabase` - база данных установленных и доступных пакетов
- Интерактивный цикл команд с обработкой ввода пользователя
- Сохранение/загрузка состояния в/из JSON файла

## Зависимости

- `serde` - для сериализации структур данных
- `serde_json` - для работы с JSON форматом

## Лицензия

MIT License