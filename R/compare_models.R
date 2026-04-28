#' Compare two mixed models using AIC and BIC
#'
#' Returns a data frame comparing two fitted lme4 models on AIC and BIC,
#' and identifies which model is preferred by each criterion.
#'
#' @param model1 A fitted \code{lmerMod} object.
#' @param model2 A fitted \code{lmerMod} object.
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{model}{Model label}
#'   \item{AIC}{Akaike Information Criterion}
#'   \item{BIC}{Bayesian Information Criterion}
#'   \item{preferred_AIC}{Logical, TRUE if this model has lower AIC}
#'   \item{preferred_BIC}{Logical, TRUE if this model has lower BIC}
#' }
#'
#' @examples
#' library(lme4)
#' data("jedi")
#' m1 = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
#' m2 = lmer(darkness ~ anger + emotional_bonds + (1 | dojo_id), data = jedi)
#' compare_models(m1, m2)
#'
#' @export
compare_models = function(model1, model2) {
  result = data.frame(
    model = c("model1", "model2"),
    AIC = c(AIC(model1), AIC(model2)),
    BIC = c(BIC(model1), BIC(model2))
  )
  result$preferred_AIC = result$AIC == min(result$AIC)
  result$preferred_BIC = result$BIC == min(result$BIC)
  result
}
