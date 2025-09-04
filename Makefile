# Makefile для Rust Package Manager

.PHONY: build run test clean demo help install release

# Переменные
CARGO = cargo
TARGET_DIR = target
BINARY_NAME = rust-package-manager

# По умолчанию - сборка проекта
all: build

# Сборка проекта
build:
	@echo "🔨 Сборка проекта..."
	$(CARGO) build

# Сборка в release режиме
release:
	@echo "🚀 Сборка release версии..."
	$(CARGO) build --release

# Запуск программы
run:
	@echo "▶️  Запуск программы..."
	$(CARGO) run

# Запуск тестов
test:
	@echo "🧪 Запуск тестов..."
	$(CARGO) test

# Запуск тестов с подробным выводом
test-verbose:
	@echo "🧪 Запуск тестов (подробный вывод)..."
	$(CARGO) test -- --nocapture

# Проверка кода
check:
	@echo "🔍 Проверка кода..."
	$(CARGO) check

# Форматирование кода
fmt:
	@echo "✨ Форматирование кода..."
	$(CARGO) fmt

# Линтинг кода
lint:
	@echo "📋 Линтинг кода..."
	$(CARGO) clippy -- -D warnings

# Очистка сборочных файлов
clean:
	@echo "🧹 Очистка сборочных файлов..."
	$(CARGO) clean
	rm -f packages.json

# Полная очистка (включая packages.json)
clean-all: clean
	@echo "🗑️  Полная очистка..."
	rm -f packages.json demo_commands.txt

# Демонстрация функций
demo:
	@echo "🎬 Демонстрация функций..."
	@./demo.sh

# Быстрый тест основных функций
quick-demo:
	@echo "⚡ Быстрая демонстрация..."
	@printf "available\ninstall firefox\ninstall python 3.12.0\nlist\nsearch browser\nremove firefox\nlist\nexit\n" | $(CARGO) run

# Установка зависимостей (обновление)
deps:
	@echo "📦 Обновление зависимостей..."
	$(CARGO) update

# Генерация документации
doc:
	@echo "📚 Генерация документации..."
	$(CARGO) doc --open

# Проверка форматирования без изменений
check-fmt:
	@echo "🔎 Проверка форматирования..."
	$(CARGO) fmt -- --check

# Полная проверка перед коммитом
pre-commit: check-fmt lint test
	@echo "✅ Все проверки пройдены!"

# Установка программы в систему
install-system: release
	@echo "📥 Установка в систему..."
	cp $(TARGET_DIR)/release/$(BINARY_NAME) /usr/local/bin/rpm-rust || \
	cp $(TARGET_DIR)/release/$(BINARY_NAME) ~/.local/bin/rpm-rust || \
	echo "❌ Не удалось установить. Скопируйте $(TARGET_DIR)/release/$(BINARY_NAME) вручную"

# Бенчмарки (если будут добавлены)
bench:
	@echo "📊 Запуск бенчмарков..."
	$(CARGO) bench

# Информация о проекте
info:
	@echo "ℹ️  Информация о проекте:"
	@echo "  Название: Rust Package Manager"
	@echo "  Версия: $(shell grep version Cargo.toml | head -n1 | cut -d'"' -f2)"
	@echo "  Язык: Rust $(shell rustc --version | cut -d' ' -f2)"
	@echo "  Cargo: $(shell cargo --version | cut -d' ' -f2)"

# Помощь
help:
	@echo "🦀 Rust Package Manager - Доступные команды:"
	@echo ""
	@echo "Сборка:"
	@echo "  build         - Сборка проекта в debug режиме"
	@echo "  release       - Сборка в release режиме"
	@echo ""
	@echo "Запуск:"
	@echo "  run           - Запуск программы"
	@echo "  demo          - Демонстрация функций (через demo.sh)"
	@echo "  quick-demo    - Быстрая демонстрация основных функций"
	@echo ""
	@echo "Тестирование:"
	@echo "  test          - Запуск тестов"
	@echo "  test-verbose  - Запуск тестов с подробным выводом"
	@echo "  bench         - Запуск бенчмарков"
	@echo ""
	@echo "Качество кода:"
	@echo "  check         - Проверка кода без сборки"
	@echo "  fmt           - Форматирование кода"
	@echo "  check-fmt     - Проверка форматирования"
	@echo "  lint          - Линтинг с clippy"
	@echo "  pre-commit    - Полная проверка перед коммитом"
	@echo ""
	@echo "Документация:"
	@echo "  doc           - Генерация и открытие документации"
	@echo ""
	@echo "Управление:"
	@echo "  deps          - Обновление зависимостей"
	@echo "  clean         - Очистка сборочных файлов"
	@echo "  clean-all     - Полная очистка"
	@echo "  install-system- Установка в систему"
	@echo ""
	@echo "Информация:"
	@echo "  info          - Информация о проекте"
	@echo "  help          - Эта справка"

# Создание архива с исходниками
archive:
	@echo "📦 Создание архива..."
	tar -czf rust-package-manager.tar.gz --exclude=$(TARGET_DIR) --exclude=packages.json .
