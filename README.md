# csvSearcher

![csvSearch](https://github.com/Kclamberth/csvSearcher/assets/127368340/bb33cb56-648a-470c-bca9-bd1af9853781)


A simple CSV (comma-separated values) file searcher that takes a user inputted csv file full of links & other information, strips out just the links, then takes a user inputted keyword, and then searches those links for the keyword.

**NOTE: Ensure your CSV file is in the same directory as the csvSearch.sh**

Useful in cases of when you need to search for a specific string in a long list of urls that are stored in the csv format. 

It outputs 2 textfiles in the same directory called notFoundList.txt , and foundList.txt.
The links that did not contain the keyword are stored in notFoundList.txt.
The links that DID CONTAIN the keyword are stored in foundList.txt.

The terminal interface will also show you the links that did not contain the keyword. 

