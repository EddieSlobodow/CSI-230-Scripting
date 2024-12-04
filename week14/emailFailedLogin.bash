
echo "To: edmond.slobodow@mymail.champlain.edu" > emailform.txt
echo "Subject: Security Incident" >> emailform.txt
echo "Test" >> emailform.txt
cat emailform.txt | ssmtp edmond.slobodow@mymail.champlain.edu
