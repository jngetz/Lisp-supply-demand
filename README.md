# Lisp-supply-demand
CPSC425 homework 3 solution
### Terminology used
IID = Item ID

WID = Warehouse ID

CS  = Current Stock

MS  = Minimum Stock required

CPI = Cost Per Item (payed only when CS < MS)

PPI = Profit Per Item (Money made not counting CPI)

WP  = Warehouse Profit (for a single IID)

TP  = Total Profit (for a single IID)

N   = Number of items supplied from a warehouse

final output type = (((IID ((WID N WP) ...) TP S) ...) ((WID (IID ...))...))

inventory type = ((IID WID CS MS CPI PPI) ...)

warning type = (WID (IID ...))