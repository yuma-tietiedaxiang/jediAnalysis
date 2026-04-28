test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})
library(lme4)

test_that("compare_models returns a data frame", {
  m1 = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  m2 = lmer(darkness ~ anger + emotional_bonds + (1 | dojo_id), data = jedi)
  result = compare_models(m1, m2)
  expect_s3_class(result, "data.frame")
})

test_that("compare_models returns two rows", {
  m1 = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  m2 = lmer(darkness ~ anger + emotional_bonds + (1 | dojo_id), data = jedi)
  result = compare_models(m1, m2)
  expect_equal(nrow(result), 2)
})

test_that("only one model preferred by AIC", {
  m1 = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  m2 = lmer(darkness ~ anger + emotional_bonds + (1 | dojo_id), data = jedi)
  result = compare_models(m1, m2)
  expect_equal(sum(result$preferred_AIC), 1)
})

test_that("AIC values are numeric", {
  m1 = lmer(darkness ~ anger + (1 | dojo_id), data = jedi)
  m2 = lmer(darkness ~ anger + emotional_bonds + (1 | dojo_id), data = jedi)
  result = compare_models(m1, m2)
  expect_type(result$AIC, "double")
})
