word=$(xclip -o)
trans $word
read result
if [[ $result == "a" ]]; then
    translation=$(trans -b $word)
    echo "$word; $translation" >> ~/chinese/auto-words
    vim ~/chinese/auto-words
fi