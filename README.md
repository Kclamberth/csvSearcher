# csvSearcher

![csvSearch](https://github.com/Kclamberth/csvSearcher/assets/127368340/bb33cb56-648a-470c-bca9-bd1af9853781)


This is a script that takes a CSV file containing URLs, visits each URL, downloads its HTML content, searches for a specified keyword, and then produces two lists: one with URLs where the keyword was found and another with URLs where the keyword was not found. The script also provides colorful output to indicate the status of each URL.

**NOTE: Ensure your CSV file is in the same directory as the csvSearch.sh**

Useful in cases for when you need to search for a specific string in a long list of webpages that are stored in the csv format. 

It outputs 2 textfiles in the **same directory** called notFoundList.txt , and foundList.txt.
The links that did not contain the keyword are stored in notFoundList.txt.
The links that DID CONTAIN the keyword are stored in foundList.txt.

You can read the text files, or output them for another use.

![csvComplete](https://github.com/Kclamberth/csvSearcher/assets/127368340/9c8fd466-cf5a-4b23-a670-335f6a45d384)

The terminal interface will also show you the links that did not contain the keyword. 

