#' Summarise fixed effects from a mixed model
#'
#' Extracts fixed effect estimates from a fitted lme4 mixed model and
#' flags whether each effect is significant using the t > 2 rule of thumb,
#' since lme4 does not provide p-values by default.
#'
#' @param model A fitted \code{lmerMod} object from \code{lme4::lmer()}.
#'
#' @return A data frame containing fixed effect estimates, standard errors,
#' t-values, and a logical column \code{significant} indicating whether
#' \code{abs(t value) > 2}.
#'
#' @examples
#' library(lme4)
#' data("jedi")
#' model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
#' summarize_fixed(model)
#'
#' @export
fixed_effects = function(model) {
  coefs = as.data.frame(coef(summary(model)))
  coefs$significant = abs(coefs$`t value`) > 2
  coefs
}
