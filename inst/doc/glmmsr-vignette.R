## ----two_level interface, eval = FALSE-----------------------------------
#  glmm(response ~ covariate + (1 | cluster), data = two_level,
#       family = binomial, method = method)

## ----two_level Laplace---------------------------------------------------
library(glmmsr)
mod_Laplace <- glmm(response ~ covariate + (1 | cluster), data = two_level,
                    family = binomial, method = "Laplace")
mod_Laplace

## ------------------------------------------------------------------------
mod_Laplace <- glmm(response ~ covariate + (1 | cluster), data = two_level,
                    family = binomial, method = "Laplace",
                    control = list(check_Laplace = TRUE))

## ----two_level_AGQ-------------------------------------------------------
glmm(response ~ covariate + (1 | cluster), data = two_level,
     family = binomial, method = "AGQ", control = list(nAGQ = 16),
     prev_fit = mod_Laplace)

## ----three_level_Laplace-------------------------------------------------
mod_3_Laplace <- glmm(response ~ covariate + (1 | cluster) + (1 | group),
                      data = three_level, family = binomial, method = "Laplace")
mod_3_Laplace

## ----three_level_AGQ, error = TRUE---------------------------------------
glmm(response ~ covariate + (1 | cluster) + (1 | group), data = three_level,
     family = binomial, method = "AGQ", control = list(nAGQ = 16))

## ----three_level_SR------------------------------------------------------
mod_3_SR <- glmm(response ~ covariate + (1 | cluster) + (1 | group),
                 data = three_level, family = binomial, method = "SR",
                 control = list(nSL = 3), prev_fit = mod_3_Laplace)
mod_3_SR

## ----three_level_SR_4----------------------------------------------------
mod_3_SR_4 <- glmm(response ~ covariate + (1 | cluster) + (1 | group),
                   data = three_level, family = binomial, method = "SR",
                   control = list(nSL = 4), prev_fit = mod_3_SR)

## ----check_mdhglm, echo = FALSE------------------------------------------
mdhglm_avail <- requireNamespace("mdhglm", quietly = TRUE)

## ----salamander_data, eval = mdhglm_avail--------------------------------
data(salamander, package = "mdhglm")

## ----salamander_Laplace, eval = mdhglm_avail-----------------------------
mod_sal_Laplace <- glmm(Mate ~ 0 + TypeM:TypeF + (1 | Male) + (1 | Female),
                        family = binomial, data = salamander, method = "Laplace")
mod_sal_Laplace

## ----salamander_SR_2, eval = FALSE---------------------------------------
#  mod_sal_SR_2 <- glmm(Mate ~ 0 + TypeM:TypeF + (1 | Male) + (1 | Female),
#                       family = binomial, data = salamander, method = "SR",
#                       control = list(nSL = 2), prev_fit = mod_sal_Laplace)

## ----salamander_SR_3, eval = mdhglm_avail, error = TRUE------------------
mod_sal_SR_3 <- glmm(Mate ~ 0 + TypeM:TypeF + (1 | Male) + (1 | Female),
                     family = binomial, data = salamander, method = "SR", 
                     control = list(nSL = 3))

## ----salamander_IS_1000, eval = mdhglm_avail-----------------------------
set.seed(1)
mod_sal_IS_1000 <- glmm(Mate ~ 0 + TypeM:TypeF + (1 | Male) + (1 | Female),
                          family = binomial, data = salamander,
                          method = "IS", control = list(nIS = 1000),
                          prev_fit = mod_sal_Laplace)
mod_sal_IS_1000

## ----lizards_BTm, message = FALSE----------------------------------------
library(BradleyTerry2)
result <- rep(1, nrow(flatlizards$contests))
lizards_mod_BTm <- BTm(result, winner, loser, ~ SVL[..] + (1|..),
                       family = binomial(link = "probit"), data = flatlizards)
summary(lizards_mod_BTm)

## ----lizards_Laplace-----------------------------------------------------
flatlizards_glmmsr <- c(list(result = result, 
                             winner = flatlizards$contests$winner, 
                             loser = flatlizards$contests$loser),
                        flatlizards$predictors)
lizards_mod_Laplace <- glmm(result ~ 0 + Sub(ability[winner] - ability[loser]), 
                            ability[liz] ~ 0 + SVL[liz] + (1 | liz),
                            data = flatlizards_glmmsr, family = binomial(link = "probit"),
                            method = "Laplace")
summary(lizards_mod_Laplace)

## ----lizards_SR_2--------------------------------------------------------
lizards_mod_SR_2 <- glmm(result ~ 0 + Sub(ability[winner] - ability[loser]), 
                         ability[liz] ~ 0 + SVL[liz] + (1 | liz),
                         data = flatlizards_glmmsr, family = binomial(link = "probit"),
                         method = "SR", control = list(nSL = 2),
                         prev_fit = lizards_mod_Laplace)
summary(lizards_mod_SR_2)

## ----lizards_SR_3--------------------------------------------------------
lizards_mod_SR_3 <- glmm(result ~ 0 + Sub(ability[winner] - ability[loser]), 
                         ability[liz] ~ 0 + SVL[liz] + (1 | liz),
                         data = flatlizards_glmmsr, family = binomial(link = "probit"),
                         method = "SR", control = list(nSL = 3),
                         prev_fit = lizards_mod_SR_2)
summary(lizards_mod_SR_3)

## ----lizards_loglikelihood-----------------------------------------------
modfr_lizards <-  find_modfr_glmm(result ~ 0 + Sub(ability[winner] - ability[loser]), 
                                  ability[liz] ~ 0 + SVL[liz] + (1 | liz), 
                                  data = flatlizards_glmmsr,
                                  family = binomial(link = "probit"))
theta_poss <- cbind(seq(0, 3, by = 0.25), 0.3)
l_SR_theta_poss <- list()
for(i in 0:4) {
  lfun_SR_i <- find_lfun_glmm(modfr_lizards, method = "SR", control = list(nSL = i))
  l_SR_theta_poss[[i + 1]] <- apply(theta_poss, 1, lfun_SR_i)
}
plot(theta_poss[,1], l_SR_theta_poss[[5]], type = "l", col = 5,
     xlab = "sigma", ylab = "log-likelihood")
for(i in 1:4) {
  lines(theta_poss[,1], l_SR_theta_poss[[i]], col = i)
}
legend("bottomright", legend = paste("nSL =", 0:4), col = 1:5, lty = 1, bty = "n")

## ----salamander_equal_ids, eval = mdhglm_avail---------------------------
female_id <- paste("F", salamander$Female, sep = "")
male_id <- paste("M", salamander$Male, sep = "")
ids <- unique(c(female_id, male_id))
salamander$female_id <- factor(female_id, levels = ids)
salamander$male_id <- factor(male_id, levels = ids)

## ----salamander_equal, eval = mdhglm_avail-------------------------------
mod_sal_equal <- glmm(Mate ~ 0 + TypeM:TypeF + Sub(propen[female_id] + propen[male_id]),
                      propen[sal] ~ 0 + (1 | sal), family = binomial, 
                      data = salamander, method = "Laplace")
mod_sal_equal

