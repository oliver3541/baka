library("RPostgreSQL")

{
  e <- list()
  e$gho <- TRUE
  e$teplota <- TRUE
  e$vietor <- TRUE
  e$oblacnost <- F
  e$vlhkost <- F
  e$tlak <- F
  e$azim <- F
  e$zen <- F
  e$elev <- F
  e$dlzkadna <- F
  e$den_hod <- c("den", "hod")[1]
  e$fve <- c("FVE Dubravy 1", "FVE Dubravy 2", "FVE Plesivec")
  e$tren_mnoz <- "najpodobnejsich 20"
  e$tren_mnoz_velkost <- 60
  e$tren_mnoz_select <- "select datum, sum(gho) gho, sum(teplota) teplota,
  sum(vietor) vietor, sum(praca) praca
  from v_data
  where fve_nazov = '%s'
  group by datum
  order by datum"
  e$tren_mnoz_opis <- "vyber 20 najpodobnejsich dni podla scitaneho gho, teploty, vetra.
  normalizovane na rozsah(skalu) medzi min a max za vsetky data elektrarne.
  gho * 90, teplota * 10, vietor * 1."
  e$neural <- TRUE
  e$neural_layers <- "c(3,2)"
  e$neural_threshold <- 0.01  #0.01 default
  e$neural_algorithm <- c("backprop", "rprop+", "rprop-", "sag", "slr")[2] # default je rprop+
  e$neural_startweights <- "rep(1, n$pocet_vah) # vektor jednotiek"
  e$forest <- TRUE
  e$forest_ntree <- 0 # 0 ak default
  e$forest_mtry <- 0 # 0 ak default
  
  n <- list()
  n$input_v <- c(e$gho, e$teplota, e$vietor, e$oblacnost, e$vlhkost, 
                 e$tlak, e$azim, e$zen, e$elev, e$dlzkadna)
  n$pocet_vah <- compute_weigths_num(length(subset(n$input_v, n$input_v == TRUE)),
                                     unq(e$neural_layers))
  n$net <- 0
  n$output <- 0
  n$stats <- 0
  
  f <- list()
  f$forest <- 0
  f$output <- 0
  f$stats <- 0
  
  t <- list()
  t$all_days <- 0
  t$all_days_count <- 0
  t$chosen_one
  t$not_i <- 0
  t$differ <- 0
  t$train_set <- 0
  t$ordered <- 0
  t$actual <- 0
  
  prog <- list()
  prog$printed <- -10
  prog$print_perc <- 0
  prog$print_perc_all <- 0
  prog$baseAll <- 0
  prog$basePart <- 0
  prog$i <- 0
  prog$actual_time <- 0
  prog$estimated_time <- 0
  prog$diff <- 1
  
  scale <- list()
  scale$maxims <- 0
  scale$minims <- 0
  scale$scale <- 0
  
  time <- list()
  time$start <- 0
  time$end <- 0
  
  db <- list()
  db$drv <- 0
  db$con <- 0
  db$result <- 0
  
}

db$drv <- dbDriver("PostgreSQL")
if (exists("db$con")) dbDisconnect(db$con)
db$con <- getConnection(db$drv)
prog$baseAll <- dbGetQuery(db$con, "SELECT count(*) FROM
                               (SELECT DISTINCT datum, fve FROM t_produkcia) s")
dbDisconnect(db$con)

if (exists("db$con")) dbDisconnect(db$con)
db$con <- getConnection(db$drv)
t$all_days <- dbGetQuery(db$con, sprintf(e$tren_mnoz_select, e$fve[3]))
dbDisconnect(db$con)

scale$maxims <- c(max(t$all_days[,2]), max(t$all_days[,3]), max(t$all_days[,4]))
scale$minims <- c(min(t$all_days[,2]), min(t$all_days[,3]), min(t$all_days[,4]))
scale$scale <- abs(scale$maxims - scale$minims)

# t$all_days_count <- nrow(t$all_days)
# prog$basePart <- t$all_days_coun
# prog$printed <- -10

for (i in 1:1) { #t$all_days_count
  # pre kazdy den vybrat trenovaciu mnozinu
  # vsetky okrem toho pre ktory idem predikovat
  t$chosen_one <- t$all_days[i,]
  t$not_i <- c(i != c(1:t$all_days_count))
  t$train_set <- t$all_days[t$not_i,]
  
  # # vypocitat podobnost
  # t$differ <- c()
  # for (j in 1:nrow(t$train_set)) { #nrow(t$train_set)
  #   t$differ[j] <- (
  #     90 * (abs(t$chosen_one['gho'] - t$train_set[j,'gho']) %p% scale$scale[1]) 
  #     +
  #       10 * (abs(t$chosen_one['teplota'] - t$train_set[j,'teplota']) %p% scale$scale[2])
  #     +
  #       (abs(t$chosen_one['vietor'] - t$train_set[j,'vietor']) %p% scale$scale[3])
  #   )
  # }
  # t$train_set['diff'] <- unlist(t$differ)
  # #t$train_set <- t$train_set[c(t$train_set[,6] < 3),]
  # #print(nrow(t$train_set))
  # 
  # t$ordered <- arrange(t$train_set, t$train_set[,6])
  # t$train_set <- t$ordered[1:e$tren_mnoz_velkost,]
  # t$actual <- vector.add(t$actual, t$chosen_one[1,'praca'])
}