# Moneymanager

This is ruby app I wrote to help me managing my personal finance. My needs are quite basic:

- Review all the bank transactions to find any fraud or issue
- Tags the important expenses and incomes to monitor the trend overtime

I wrote my own tool instead of using MoneyWiz because I like writing ruby code and all the commercial apps are overcomplicated for me

## Features

* Import transactions from a `CSV - CAMT` file. I'm not sure about your bank, but SparkasseBerlin has this option.
* The import process is idempotent, the already imported transactions are just skipped.
* Print the list of transacions.
* Review the transaction and put a checkmarks on the approved ones.
* Tag the transactions
* Analize the transaction with the reports

## Reports

* Total income
* Total expense
* All incomes grouped by category
* All expenses grouped by category
* Trend of tag overtime

## Why you shouldn't use this

* Probably your needs are different from mine.
* The database is just a plain, non-encrypted file. 
* There are no fancy charts (so far)

## Usage

#### Install the gem

	$ gem install moneymanager

#### Import your CSV FILE

	$ mm add exported.csv
	Parsed:   99
	Skipped:   0
	Inserted: 99
	# If executed twice, the entries are not duplicated
	$ mm add exported.csv
	Parsed:   99
	Skipped:  99
	Inserted: 0

#### Print the transactions
By default all the transactions are printed. A month can be specified with the `--month` parameter

	$ mm print
	+-----+----------+--------------+----------------------------------------------------+-------------+
	| ✔/✖︎ | Date     | Tag          | Reason                                             | Amount      |
	+-----+----------+--------------+----------------------------------------------------+-------------+
	|  ✖︎︎  | 17/08/01 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✖︎  | 17/08/01 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✖︎  | 17/08/01 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✖︎  | 17/08/01 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✖︎  | 17/08/01 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✖︎  | 17/08/02 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✖︎  | 17/08/31 |              | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	+-----+----------+--------------+----------------------------------------------------+-------------+


#### Review and approve the transactions
Flag all the approved transaction.

	$ mm review
	+----------+------------------------------------------------------+
	| Date     | 2017-08-01                                           |
	| Reason   | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎   |
	| Amount   | -999.0 €                                             |
	| Company  | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎   |
	| Approved | ✖                                                    |
	| Tag      |                                                      |
	+----------+------------------------------------------------------+
	Do you recognize? (Use arrow keys, press Enter to select)
	‣ yes
	  no
	  skip
	  abort



#### Tag each transaction

Assign a tag to a transaction. To generate hierarchy of tags, use a `/` like `Car/Insurance`

	$ mm tag
	+----------+------------------------------------------------------+
	| Date     | 2017-08-01                                           |
	| Reason   | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎   |
	| Amount   | -99.0 €                                              |
	| Company  | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎   |
	| Approved | ✔︎                                                    |
	| Tag      |                                                      |
	+----------+------------------------------------------------------+
	Do you want add a tags? (Use arrow keys, press Enter to select)
	‣ 1. Skip
	  2. Abort
	  3. Create
	  Car/Gasoline
	  Car/Insurance
	  Car/Tire
	  Heating
	  Mortage
	  


#### Enjoi the list of transaction

	$ mm print
	+-----+----------+------------------------+--------------------------------------------------+-------------+
	| ✔/✖︎ | Date     | Tag                    | Reason                                           | Amount      |
	+-----+----------+------------------------+--------------------------------------------------+-------------+
	|  ✔︎  | 17/08/01 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✔︎  | 17/08/01 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✔︎  | 17/08/01 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✔︎  | 17/08/31 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✔︎  | 17/08/31 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✔︎  | 17/08/31 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	|  ✔︎  | 17/08/31 | ◼◼◼◼◼◼ Censored ◼◼◼◼◼◼ | ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼ C E N S O R E D ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼︎ |  99999.99 € |
	+-----+----------+------------------------+--------------------------------------------------+-------------+

## Reporting

#### Total (Incomes or Expenses)

Print the total of the incomes or expenses on the whole archive or on the selected month

	$ mm report --month 8

    $ mm report --month 8
	Which type of report? (Use arrow keys, press Enter to select)
	‣ Total (Incomes)
	  Total (Expenses)
	  All Incomes
	  All Expenses
	  Specific Tag


	Which type of report? Total (Incomes)
	+-----------+
	| 99999.0 € |
	+-----------+


#### All Incomes/Expenses

Print the list of all the incomes (or expenses) grouped by tag. The entries without a tag are grouped into the `Unknown` tag.
 
     $ mm report
    Which type of report? (Use arrow keys, press Enter to select)
      Total (Incomes)
	  Total (Expenses)
	‣ All Incomes
	  All Expenses
	  Specific Tag
    
      
    
    Which type of report? All Incomes
	+--------------+----------+
	| Kindergeld   |  999.0 € |
	| Salary       |  999.0 € |
	| Investments  | 9999.0 € |
	| Stockoptions | 9999.0 € |
	| Unknown      |  999.0 € |
	+--------------+----------+
	|             9999999.0 € |
	+--------------+----------+
    

#### One tag grouped by month

Print al list in which the entries with the selected tag are grouped by month. This is the report you want to use to understand if your heating bill is becoming bigger overtime.

     $ mm report
    Which type of report? (Use arrow keys, press Enter to select)
      Total (Incomes)
	  Total (Expenses)
	  All Incomes
	  All Expenses
	‣ Specific Tag
    
    Select a tag. (Use arrow keys, press Enter to select)
    ‣ Heating
      Mortage
      Car/Gasoline
      Car/Insurance
      Car/Tire
    
	Select a tag. Heating
	+-----------+---------+
	| August    | -99.0 € |
	| September | -99.0 € |
	+-----------+---------+
	|            -198.0 € |
	+-----------+---------+




## To do

* [ ] Report for nested tags ( Car/Gasoline, Car/Insurance etc)
* [ ] Multiple tags
* [x] Report for one tag splitted by month
* [ ] Add a backup options
* [ ] Manage multiple banck account
* [ ] Exclude account transfer from the list of expenses/incomes
* [ ] Print fancy chart in html
* [ ] Filter by one single entry

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ignazioc/moneymanager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

