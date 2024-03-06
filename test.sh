branch_name=$(git rev-parse --abbrev-ref HEAD)
      
content=$(cat .releaserc)

channel=$(echo "$content" | jq -r --arg branch "$branch_name" '.branches[] | select(.name | test("^" + $branch + "$")) | .channel')

echo "::set-output name=channel::$channel"