{ pkgs}:

(pkgs.writeShellScriptBin "gifify" ''
    #!/usr/bin/env bash
    #
    # gifify: convert a video to a high-quality GIF, optionally optimize size
    # Usage: gifify [-o|--optimize] <input-video> <output-gif>

    OPTIMIZE=false

    # Parse flags
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -o|--optimize)
          OPTIMIZE=true
          shift
          ;;
        -*)
          echo "Unknown option: $1"
          echo "Usage: gifify [-o|--optimize] <input-video> <output-gif>"
          exit 1
          ;;
        *)
          break
          ;;
      esac
    done

    if [ $# -ne 2 ]; then
      echo "Usage: gifify [-o|--optimize] <input-video> <output-gif>"
      exit 1
    fi

    input="$1"
    output="$2"
    tmp_palette=$(mktemp /tmp/palette.XXXXXX.png)

    # 1) Generate optimized palette
    ffmpeg -hide_banner -loglevel error \
      -i "$input" \
      -vf "fps=15,scale=iw:-1:flags=lanczos,palettegen=stats_mode=diff" \
      "$tmp_palette" \
      || { echo "▸ palette generation failed"; rm -f "$tmp_palette"; exit 1; }

    # 2) Create the GIF using that palette
    ffmpeg -hide_banner -loglevel error \
      -i "$input" -i "$tmp_palette" \
      -filter_complex "fps=15,scale=iw:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=5" \
      "$output" \
      || { echo "▸ GIF creation failed"; rm -f "$tmp_palette"; exit 1; }

    rm -f "$tmp_palette"
    echo "✔ Created GIF → $output"

    # 3) If requested, run gifsicle -O3 to optimize size
    if [ "$OPTIMIZE" = true ]; then
      if ! command -v gifsicle &> /dev/null; then
        echo "⚠ gifsicle not found; install it to optimize. Skipping optimization."
      else
        tmp_optimized=$(mktemp /tmp/opt.XXXXXX.gif)
        gifsicle -O3 "$output" > "$tmp_optimized" \
          && mv "$tmp_optimized" "$output" \
          && echo "✔ Optimized GIF → $output" \
          || { echo "▸ gifsicle optimization failed"; rm -f "$tmp_optimized"; }
      fi
    fi
  '')