python3.10 -u main.py --listen --port 7860 &

PID_COMFY=$!
echo "ComfyUI démarré avec PID: $PID_COMFY"

# Attendre 30 secondes
sleep 30

python3.10 custom_nodes/ComfyUI-Manager/cm-cli.py update all

python3.10 custom_nodes/ComfyUI-Manager/cm-cli.py fix all

# Tuer le processus ComfyUI
kill $PID_COMFY
echo "ComfyUI (PID: $PID_COMFY) a été arrêté"

python3.10 -u main.py --listen --port 7860 &