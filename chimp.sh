#!/bin/bash

apikey_file=$HOME/.mailchimp_apikey
apikey=$(cat $apikey_file 2> /dev/null)
tmp_file=.chimp.fasd00fhf0eqfewqp.tmp # arbitrary

echo "> REPL for Mailchimp API v2.0 (Works only for JSON at the time being)"

if [ ! -f $apikey_file ]
  then
    echo -n ">> Please enter your API key: "
    read apikey
    echo $apikey > $apikey_file
fi

echo "> Syntax is '<command> [<json>]', like in 'lists/members {\"id\": \"xyz\"}'"
echo "> Check out the README for more"
echo "> Entering loop, press Ctrl-C to quit when you're done"

while true
do
  echo -n "mailchimp> "

  read input

      command=$(cut -d" " -f1 <<< $input)
         data=$(cut -d" " -f2- <<< $input)
  data_center=$(cut -d- -f2 <<< $apikey)
          sep=','

  if [ $data = $command 2> /dev/null ]
  then
    data='{}'
    sep=''
  fi

  curl https://$data_center.api.mailchimp.com/2.0/$command \
    --data-ascii "{\"apikey\": \"$apikey\"$sep$(cut -c2- <<< $data)" \
    2> /dev/null \
    | python -m json.tool \
    | pygmentize -l javascript \
    > $tmp_file &

  (pid=$BASHPID;
   (while [ -e /proc/$! ]; do sleep 0.1; done
    kill $pid) &
   exec cmatrix -u 1)

   cat $tmp_file | less -r
   rm $tmp_file
done

exit 0;
