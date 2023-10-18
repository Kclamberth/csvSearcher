#!/bin/bash

clear 

update_screen() {
    #tput clear
    #tput cup 0 0
    echo -e "${YELLOW}Link #    STATUS   Keyword      Link${RESET}"
}

#colors
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

#user input
echo "Please enter the CSV file name (e.g., ProjectZomboidMods.csv):"
read csv_file
csv_directory=$(find ~ -name "$csv_file" | xargs dirname 2>/dev/null | head -1 )
search_directory=$(find ~ -name "csvSearch.sh" | xargs dirname 2>/dev/null | head -1 )

#if user inputted CSV file exists
if [ -f "$csv_directory/$csv_file" ]; then
    echo " "
    echo "Please enter the KEYWORD to search for in '$csv_file'"
    read key_word
    echo " " 
    echo -e "${YELLOW}Beginning search of '$csv_file' file for '$key_word'...${RESET}"
    sleep 2

    #Find ProjectZomboid CSV file
    cd "$csv_directory"

    #header
    update_screen

    #read csv file & pull links, store in new list
    cat "$csv_file" 2>/dev/null | awk -F "https://" '{print $2}'| awk -F "," '{print $1}' > $search_directory/foundList.txt
    sed -i '/^$/d' $search_directory/foundList.txt && sed -i 's/^/https:\/\//g' $search_directory/foundList.txt
    linklistcount=$(cat $search_directory/foundList.txt | wc -l)
    
    #Read every link in list
    for ((link = 1; link <="$linklistcount"; link ++)); do

        #visit each webpage, download index.html
        link_url=$(cat $search_directory/foundList.txt | sed -n "${link}p")
        wget "$link_url" > /dev/null 2>&1
        if [ -f "$search_directory/notFoundList.txt" ]; then
            nfcount=$(cat $search_directory/notFoundList.txt | wc -l)
        else
            nfcount=0
        fi

        #if index.html file exists 
        for file in *index*; do
            if [ -f "$file" ]; then
                cat *index* | grep -i "$key_word" > /dev/null 2>&1 #pull keyword out of page
                code=$?

                #if keyword was FOUND
                if [[ $code -eq 0 ]];
                    then
                        num1=$(expr $link + $nfcount)
                        printf -v padded_link "%03d" "$num1"
                        echo -ne "[$padded_link/$linklistcount] ${GREEN}[FOUND]${RESET} '$key_word'    $link_url\r"
                        if [ "$padded_link" -eq "$linklistcount" ]; then
                            echo -ne "[$padded_link/$linklistcount] Links Searched.                                                                                           \n"
                        fi

                    #if keyword was NOT FOUND     
                    else
                        sed -i "${link}d" $search_directory/foundList.txt > /dev/null 2>&1
                        num1=$(expr $link + $nfcount)
                        printf -v padded_link "%03d" "$num1"
                        echo $link_url >> $search_directory/notFoundList.txt
                        echo -e "[$padded_link/$linklistcount] ${RED}[ERROR]${RESET} '$key_word'    $link_url, sending to notFoundList.txt."
                fi

                #remove index file, ready for next loop
                rm "$file"
            fi
        done
    done

    #removes whitespace and newlines from each finished list
    sed -i 's/^[ \t]*//;s/[ \t]*$//' $search_directory/notFoundList.txt
    sed -i 's/^[ \t]*//;s/[ \t]*$//' $search_directory/foundList.txt
    sed -i '/^$/d' $search_directory/notFoundList.txt
    sed -i '/^$/d' $search_directory/foundList.txt

    sleep 2

    #exit statements
    echo " "
    echo " " 
    echo "Finished search for '$key_word' in each link of '$csv_file'"
    sleep 2
    number=$(cat $search_directory/foundList.txt | wc -l)
    number2=$(cat $search_directory/notFoundList.txt | wc -l)
    printf -v padded_number2 "%03d" "$number2"
    echo " "
    echo -e "${GREEN}[$number]${RESET} links found with '$key_word', stored in foundList.txt"
    echo -e "${RED}[$padded_number2]${RESET} links found with NO MENTION of '$key_word', stored in notFoundList.txt."

#runs only if user inputted csv file name is not found
else
    echo " "
    echo "The file '$csv_file' does NOT exist in this directory."
    echo "Ensure you typed it in correctly, or are in the correct directory."
fi
