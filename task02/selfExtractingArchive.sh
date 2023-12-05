#!/bin/bash

while getopts ":d:n:" opt; do
  case $opt in
    d)
      dir_path="$OPTARG"
      ;;
    n)
      name="$OPTARG"
      ;;
    \?)
      echo "Неверный параметр: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Параметр -$OPTARG должен быть заполнен" >&2
      exit 1
      ;;
  esac
done

if [ -z "$dir_path" ] || [ -z "$name" ]; then
  echo "Usage: $0 -d <dir_path> -n <name>"
  exit 1
fi

echo -e "#!/bin/bash\n" > "$name"
chmod +x "$name"

tar czf "$name.tar.gz" "$dir_path"

cat "$name.tar.gz" >> "$name"

chmod +x "$name"

echo "Скрипт успешно завершён"
