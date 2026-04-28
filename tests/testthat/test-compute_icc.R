library(lme4)

test_that("compute_icc returns a data frame", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = compute_icc(model)
  expect_s3_class(result, "data.frame")
})

test_that("compute_icc returns correct columns", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = compute_icc(model)
  expect_named(result, c("icc", "design_effect"))
})

test_that("ICC is between 0 and 1", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = compute_icc(model)
  expect_gte(result$icc, 0)
  expect_lte(result$icc, 1)
})

test_that("design effect is greater than 1", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = compute_icc(model)
  expect_gte(result$design_effect, 1)
})
