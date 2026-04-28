library(lme4)

test_that("fixed_effects returns a data frame", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = fixed_effects(model)
  expect_s3_class(result, "data.frame")
})

test_that("fixed_effects contains significant column", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = fixed_effects(model)
  expect_true("significant" %in% colnames(result))
})

test_that("significant column is logical", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = fixed_effects(model)
  expect_type(result$significant, "logical")
})

test_that("anger is significant predictor of darkness", {
  model = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  result = fixed_effects(model)
  expect_true(result["anger", "significant"])
})
