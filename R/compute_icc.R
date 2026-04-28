#' Compute ICC and Design Effect from a mixed model
#'
#' Extracts the intraclass correlation coefficient (ICC) and design effect
#' from a fitted lme4 mixed model.
#'
#' @param model A fitted \code{lmerMod} object from \code{lme4::lmer()}.
#'
#' @return A data frame with two columns:
#' \describe{
#'   \item{icc}{Intraclass correlation coefficient}
#'   \item{design_effect}{Design effect based on average cluster size}
#' }
#'
#' @examples
#' library(lme4)
#' data("jedi")
#' model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
#' compute_icc(model)
#'
#' @export
compute_icc = function(model) {

  var = as.data.frame(VarCorr(model))
  icc = var$vcov[1] / sum(var$vcov)
  n_per_cluster = nrow(model@frame) / length(unique(model@frame$dojo_id))
  design_effect = 1 + (n_per_cluster - 1) * icc
  data.frame(icc = icc, design_effect = design_effect)

}
