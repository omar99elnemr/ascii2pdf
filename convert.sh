#!/bin/bash

in_dir="/opt/incoming"
out_dir="/opt/outgoing"

echo "Watching for new .txt files in $in_dir..."

while true; do
    for file in "$in_dir"/*.txt; do
        [ -e "$file" ] || continue
        filename=$(basename "$file")
        base="${filename%.txt}"
        out_pdf="$out_dir/$base.pdf"

        if [ ! -f "$out_pdf" ]; then
            echo "Converting $filename to PDF..."
            enscript "$file" -o - | ps2pdf - "$out_pdf"
        fi
    done
    sleep 5
done
#!/bin/bash

in_dir="/opt/incoming"
out_dir="/opt/outgoing"

inotifywait -m -e create --format "%f" "$in_dir" | while read filename; do
    if [[ "$filename" == *.txt ]]; then
        base="${filename%.txt}"
        enscript "$in_dir/$filename" -o - | ps2pdf - "$out_dir/$base.pdf"
    fi
done

