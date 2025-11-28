#!/bin/bash

# --- CONFIGURATION ---
API_URL="https://dtek.dedyn.io/schedule/simple?password=dtek2025&queue=GPV3.1&days=2" # Paste your URL inside the quotes
# ---------------------
#!/bin/bash

# Dependency Check
if ! command -v jq &> /dev/null; then
    echo '{"text": "ERR", "tooltip": "Missing dependency: jq", "class": "error"}'
    exit 0
fi

update_widget() {
    # 1. Fetch Data
    # Capture stderr to suppress curl's progress bar but keep errors if needed
    # --fail causes curl to return non-zero on server errors (404/500)
    json_data=$(curl -s --fail --max-time 10 "$API_URL")
    
    # Check curl exit code directly
    if [ $? -ne 0 ]; then
        echo '{"text": "Offline", "tooltip": "Connection Failed", "class": "disconnected"}'
        return 1
    fi

    # 2. Parse Data
    # We check if 'q' exists to verify we got valid JSON
    queue_name=$(echo "$json_data" | jq -r '.q // empty')
    
    if [ -z "$queue_name" ]; then
        echo '{"text": "API Err", "tooltip": "Invalid JSON data", "class": "error"}'
        return 1
    fi

    # Load Today's 24 statuses
    schedule=()
    while IFS= read -r line; do
        schedule+=("$line")
    done < <(echo "$json_data" | jq -r '.d[0][]')

    current_hour=$(date +%-H)

    # 3. Build Tooltip
    tooltip_text="Queue: $queue_name"$'\n'"<b>Today's Schedule:</b>"$'\n'
    
    for h in {0..23}; do
        status=${schedule[$h]:-9} 
        case "$status" in
            0) icon="🔴"; st="OFF" ;;
            1) icon="🟢"; st="ON " ;;
            2|3) icon="🟡"; st="MAY" ;;
            *) icon="⚪"; st="???" ;;
        esac

        if [ "$h" -eq "$current_hour" ]; then
            line="<b>➜ %02d:00  %s %s</b>"
        else
            line="     %02d:00  %s %s"
        fi
        
        printf -v formatted_line "$line" "$h" "$icon" "$st"
        tooltip_text+="${formatted_line}"$'\n'
    done

    # 4. Build Rectangles (Next 5 Hours)
    output_text=""
    rect="▮"
    
    for i in {0..4}; do
        target_hour=$((current_hour + i))
        if [ "$target_hour" -lt 24 ]; then
            status=${schedule[$target_hour]}
            case "$status" in
                0) color="#ff5555" ;; # Red
                1) color="#50fa7b" ;; # Green
                2|3) color="#ffb86c" ;; # Orange
                *) color="#6272a4" ;; # Grey
            esac
            output_text="${output_text}<span color='${color}' rise='7000'>${rect}</span>"
        else
            output_text="${output_text}<span color='#44475a' rise='7000'>${rect}</span>"
        fi
    done
    
    # 5. Output Final JSON
    # --unbuffered is crucial for the pipe to Waybar working instantly
    jq -nc --unbuffered \
       --arg text "$output_text" \
       --arg tooltip "$tooltip_text" \
       '{text: $text, tooltip: $tooltip, class: "custom-dtek"}'

    return 0
}

# --- MAIN LOOP ---
while true; do
    # Run the function
    if update_widget; then
        # SUCCESS (Return code 0)
        # Calculate seconds until the next hour (e.g., 14:00:00)
        current_epoch=$(date +%s)

        target_epoch=$(( (current_epoch / 3600 + 1) * 3600 + 10 ))
        
        # Sleep loop: Sleep in small chunks until we reach the target
        while true; do
            now=$(date +%s)
            remaining=$((target_epoch - now))

            # If we passed the target (or are close), break and update
            if [ "$remaining" -le 0 ]; then
                break
            fi

            # If remaining time is huge, sleep max 30s at a time
            # This allows the script to catch up quickly after system wake
            if [ "$remaining" -gt 300 ]; then
                sleep 300
            else
                sleep "$remaining"
                break
            fi
        done
    else
        # FAILURE (Return code 1)
        # Retry in 5 minutes
        sleep 300
    fi
done

