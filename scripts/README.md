```markdown
# Linux Productivity Guardian

[![Linux](https://img.shields.io/badge/OS-Linux-orange.svg)](https://www.linux.org/)
[![Distro](https://img.shields.io/badge/Distro-Arch%20%7C%20CachyOS-blue.svg)](https://archlinux.org/)

**Linux Productivity Guardian** — это системная служба для Linux (Arch Linux / CachyOS), предназначенная для автоматизации удаления отвлекающего программного обеспечения. Проект создан для фана, практики и поддержания фокуса на рабочих задачах.

---

## Возможности

* **Автоматизация**: Автоматическая проверка и удаление заданного софта (например, *Dota 2*).
* **Интеграция с Systemd**: Работает как фоновая служба, обеспечивая постоянное соблюдение правил продуктивности.
* **Концентрация на важном**: Помогает устранить «пожирателей времени», чтобы вы могли сосредоточиться на учебе и проектах.

---

## Установка

### 1. Автоматическая установка (рекомендуется)

Просто склонируйте репозиторий и запустите готовый скрипт:

```bash
# Клонирование репозитория
git clone [https://github.com/KachanArtmee/linux-productivity-guardian.git](https://github.com/KachanArtmee/linux-productivity-guardian.git)

# Переход в директорию
cd linux-productivity-guardian

# Запуск установщика
chmod +x install.sh
./install.sh