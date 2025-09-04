# 📚 Примеры использования Rust Package Manager

## Базовые операции

### Запуск программы
```bash
cargo run
```

### Получение справки
```
rpm> help
```

## Работа с пакетами

### Просмотр доступных пакетов
```
rpm> available
```

Вывод:
```
Доступные пакеты:
Название             Версия          Описание
------------------------------------------------------------
apache               2.4.57          Apache HTTP Server
chrome               119.0.6045      Google Chrome browser
curl                 8.4.0           Command line tool for transferring data
docker               24.0.7          Container platform
emacs                29.1            GNU Emacs text editor
firefox              118.0.1         Mozilla Firefox web browser
...
```

### Установка пакетов

#### Установка с версией по умолчанию (0.1.0)
```
rpm> install firefox
✓ Пакет 'firefox' версии 0.1.0 успешно установлен
```

#### Установка с указанием версии
```
rpm> install python 3.12.0
✓ Пакет 'python' версии 3.12.0 успешно установлен
```

#### Установка пользовательского пакета
```
rpm> install myapp 2.5.0
✓ Пакет 'myapp' версии 2.5.0 успешно установлен
```

### Просмотр установленных пакетов
```
rpm> list
```

Вывод:
```
Установленные пакеты:
Название             Версия          Описание
------------------------------------------------------------
firefox              0.1.0           Mozilla Firefox web browser
myapp                2.5.0           Пользовательский пакет
python               3.12.0          Python programming language
```

### Удаление пакетов
```
rpm> remove firefox
✓ Пакет 'firefox' версии 0.1.0 успешно удален
```

## Поиск пакетов

### Поиск по названию
```
rpm> search python
```

Вывод:
```
Найденные пакеты по запросу 'python':
Название             Версия          Описание
------------------------------------------------------------
python               3.11.6          Python programming language [УСТАНОВЛЕН]
```

### Поиск по описанию
```
rpm> search browser
```

Вывод:
```
Найденные пакеты по запросу 'browser':
Название             Версия          Описание
------------------------------------------------------------
chrome               119.0.6045      Google Chrome browser
firefox              118.0.1         Mozilla Firefox web browser
```

### Поиск по частичному совпадению
```
rpm> search data
```

Вывод:
```
Найденные пакеты по запросу 'data':
Название             Версия          Описание
------------------------------------------------------------
curl                 8.4.0           Command line tool for transferring data
mongodb              7.0.2           Document database
mysql                8.0.35          MySQL database server
postgresql           16.0            PostgreSQL database
redis                7.2.3           In-memory data structure store
```

## Сценарии использования

### Сценарий 1: Настройка среды разработки
```
rpm> install git 2.42.0
rpm> install vscode 1.84.2
rpm> install nodejs 20.9.0
rpm> install python 3.11.6
rpm> list
```

### Сценарий 2: Установка веб-сервера
```
rpm> install nginx 1.24.0
rpm> install mysql 8.0.35
rpm> install redis 7.2.3
rpm> available
```

### Сценарий 3: Поиск и установка редакторов
```
rpm> search editor
rpm> install vim
rpm> install emacs
rpm> list
```

### Сценарий 4: Очистка системы
```
rpm> list
rpm> remove vim
rpm> remove emacs
rpm> list
```

## Обработка ошибок

### Попытка установить уже установленный пакет
```
rpm> install python
rpm> install python
❌ Ошибка: Пакет 'python' уже установлен
```

### Попытка удалить несуществующий пакет
```
rpm> remove nonexistent
❌ Ошибка: Пакет 'nonexistent' не найден среди установленных
```

### Неверная команда
```
rpm> invalidcommand
❌ Неизвестная команда: 'invalidcommand'
Введите 'help' для справки
```

### Отсутствие аргументов
```
rpm> install
❌ Ошибка: укажите название пакета

rpm> remove
❌ Ошибка: укажите название пакета

rpm> search
❌ Ошибка: укажите поисковый запрос
```

## Автоматизация

### Использование с пайпом
```bash
echo -e "install firefox\ninstall python 3.12.0\nlist\nexit" | cargo run
```

### Создание скрипта команд
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

## Состояние данных

### Файл packages.json
После установки нескольких пакетов файл `packages.json` будет содержать:

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
    // ... все доступные пакеты
  }
}
```

### Персистентность данных
- Данные сохраняются автоматически после каждой операции установки/удаления
- При перезапуске программы состояние восстанавливается из файла
- Если файл отсутствует, создается новый с пустым списком установленных пакетов

## Советы по использованию

1. **Используйте поиск** для нахождения нужных пакетов перед установкой
2. **Указывайте версии** для точного контроля версий пакетов
3. **Регулярно проверяйте** список установленных пакетов командой `list`
4. **Создавайте скрипты** для автоматизации установки наборов пакетов
5. **Делайте резервные копии** файла `packages.json` для сохранения состояния