print() {

    echo "$1"
}

DATA='{"NAME": "kamuri"}'

print "hello world $(echo $DATA | jq -r '.NAME')"
