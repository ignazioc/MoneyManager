# Moneymanager

This is ruby app I wrote to help me managing my personal finance. Some features are still missing, I'll add in the future.
I ended up writing my own tool instead of using MoneyWiz et simila is that all the tools I tried are either overcomplicated or dont'have the basic information I need (and also because I like writing Ruby code)

## Features

* Import transactions from a `CSV - CAMT` file. I'm not sure about your bank, but SparkasseBerlin has this option.
* The import process is idempotent. Import same transaction multiple times doesn't get duplicate.
* Print the list of transacions.
* Review the transaction and flag all the approved ones.
* Tag the transaction and assign a tag to each one
* Print the summary of income/expense general or divided by category.
* All the actions have an options to consider only a specific month.

## Why you shouldn't use this

* The database is just a plain, non-encrypted file. 
* There are no fancy charts.
* The `print/review/tag` taks are _monthly_ based. If you have undreds of transaction per month using this tool can be tedious.
* 

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

Assign a tag to each (or not) transaction. To generate hierarchy of tags, use a `/` like `Car/Insurance`s

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

#### Global Incomes/Expenses

	$ mm report --month 8

    $ mm report --month 8
    Which type of report? (Use arrow keys, press Enter to select)
    ‣ Global Incomes/Expenses
      All categories
      One category


    +---------+-----------+
    |       Summary       |
    +---------+-----------+
    | Income  |  1234.0 € |
    | Expense | -5678.0 € |
    | Delta   |  9999.0 € |
    +---------+-----------+

#### Global Incomes/Expenses

    
     $ mm report
    Which type of report? (Use arrow keys, press Enter to select)
      Global Incomes/Expenses
    ‣ All categories
      One category
    
    
    +------------+----------+
    |        Incomes        |
    +------------+----------+
    | Salary     |  999.0 € |
    | Investment |  999.0 € |
    | Rent       |  999.0 € |
    +------------+----------+
    +-------------------+-----------+
    |           Expenses            |
    +-------------------+-----------+
    | Heating           |   -99.0 € |
    | Mortage           |   -99.0 € |
    | Car/Gasoline      |   -99.0 € |
    | Car/Insurace      | -9999.0 € |
    | Car/Tire          |  -999.0 € |
    +-------------------+-----------+
    

#### Report for one Tag


     $ mm report
    Which type of report? (Use arrow keys, press Enter to select)
      Global Incomes/Expenses
      All categories
    ‣ One category
    
    Select a tag. (Use arrow keys, press Enter to select)
    ‣ Heating
      Mortage
      Car/Gasoline
      Car/Insurance
      Car/Tire
    
    +-----------------+---------+
    |         Expenses          |
    +-----------------+---------+
    | Heating         | -99.0 € |
    +-----------------+---------+




## Next release

* Report for nested tags ( Car/Gasoline, Car/Insurance etc)
* Multiple tags
* Report for one tag splitted by month

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ignazioc/moneymanager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

