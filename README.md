# docker
```
docker rm -f bot-01 bot-02 bot-03 bot-04
docker rmi -f dotaja/jokowi-dotaja:v1
docker system prune -a --volumes -f
for i in {1..4}; do
    NAME="bot-0$i"
    SLOT_FILE="$(pwd)/slot_bot$i.txt"
    touch "$SLOT_FILE"
    
    docker run -d \
      --name "$NAME" \
      --restart unless-stopped \
      --cpus="1" \
      --memory="3g" \
      --shm-size="2g" \
      --tmpfs /tmp:rw,size=256m \
      --tmpfs /app/chrome_profiles:rw,size=2g \
      --tmpfs /app/fresh_data:rw,size=128m \
      -v "$SLOT_FILE":/app/slot.txt \
      dotaja/jokowi-dotaja:v1
      
    sleep 10
done
```
