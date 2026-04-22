#!/bin/bash

echo "[*] Memulai pengecekan bot fleet..."

for i in {1..4}; do
    NAME="bot-0$i"
    SLOT_FILE="$(pwd)/slot_bot$i.txt"
    
    echo "----------------------------------------"
    
    # PROTEKSI: Cek apakah kontainer dengan nama tersebut sudah ada (baik jalan atau standby)
    if [ "$(docker ps -aq -f name=^/${NAME}$)" ]; then
        echo "[!] $NAME sudah ada. Melewati..."
        continue
    fi

    echo "[*] $NAME belum ada. Menyiapkan deployment..."
    touch "$SLOT_FILE"
    
    docker run -d \
      --name "$NAME" \
      --restart unless-stopped \
      --cpus="1.5" \
      --memory="5g" \
      --shm-size="2g" \
      --tmpfs /tmp:rw,size=256m \
      --tmpfs /app/chrome_profiles:rw,size=2g \
      --tmpfs /app/fresh_data:rw,size=128m \
      -v "$SLOT_FILE":/app/slot.txt \
      dotaja/jokowi-dotaja:v1
      
    echo "[+] Container $NAME berhasil dijalankan. Jeda 10 detik..."
    sleep 10
done

echo "----------------------------------------"
echo "[+] Proses selesai! Fleet aman."
