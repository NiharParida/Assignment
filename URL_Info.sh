
#!/bin/bash

read -p "Enter the URL's in Space seperated" line 
list=(${line})

for i in ${list[@]}
do
  (time wget -d $i) > output.txt 2>&1
  Http_Status_Code=`cat output.txt | grep -i -A1 "response end" | tail -n2 | grep -i -A1 "response end" | tail -n1`
 if [ -z "$Http_Status_Code" ]
 then
        Http_Status_code="NA Check Manually"
 else
        Http_Status_code=$Http_Status_Code
 fi
  Response_Time=`cat output.txt | grep -i "real" | awk '{print $2}'`
 if [ -z "$Response_Time" ]
 then
        Response_time="NA Check Manually"
 else
        Response_time=$Response_Time
 fi
  echo "$i,$Http_Status_code,$Response_time" >> files.txt
done

echo "wbsite-name,http_status_code,response_time/latency" > Final.csv
cat files.txt | sort -k3h >> Final.csv
cat Final.csv
rm Final.csv
rm files.txt