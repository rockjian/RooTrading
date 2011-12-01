#-- connect to SQLite DB
setwd("D:/Jhuang/R/RTrading/")
library(RSQLite)
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname="market.db")

#-- connect to Bloomberg
library(RBloomberg)
conn <- blpConnect()

#-- Get SPX Mini contract intraday price data, up to 195 days
ESID <- bar(conn, "ES1 Index", "TRADE", "2011-05-18 08:00:00.000", "2011-11-29 18:00:00.000", "5")
dbWriteTable(con, "ESID", ESID, overwrite=TRUE)


#-- Get SPX Mini contract close price data, starting from 1997
ESD <- bdh(conn, "ES1 Index", c("PX_OPEN", "PX_HIGH", "PX_LOW", "PX_LAST", "VOLUME", "OPEN_INT"),  "19971001", "20111129")
dbWriteTable(con, "ESD", ESD, overwrite=TRUE)


#-- Get SPX full contract close price data, starting from 1982
SPD <- bdh(conn, "SP1 Index", c("PX_OPEN", "PX_HIGH", "PX_LOW", "PX_LAST", "VOLUME", "OPEN_INT"),  "19820501", "20111129")
dbWriteTable(con, "SPD", SPD, overwrite=TRUE)


#-- Get SPX index data, starting from 1957
SPX <- bdh(conn, "SPX Index", c("PX_OPEN", "PX_HIGH", "PX_LOW", "PX_LAST", "VOLUME"),  "19570401", "20111129")
dbWriteTable(con, "SPX", SPX, overwrite=TRUE)

